function conda(cmd, varargin)
% Handle Python environments using Continuum's conda

% TODO
% 
% - install to userpath/conda
% - don't shadow conda's commands
% - make it stupid simple to get started quickly

persistent conda_path conda_env conda_py

switch cmd
    % TODO this prevents true conda install from working.
    case 'install'
        install(varargin{:});
    case 'use'
        if nargin < 2
            if isempty(conda_path)
                fprintf('no conda installation known\n');
            elseif isempty(conda_env)
                fprintf('using conda %s, but no environment set.\n', ...
                        conda_path);
            else
                fprintf('using conda %s, with environment %s\n', conda_path, conda_env);
            end
        else
            conda_path_ = fullfile(varargin{1}, 'bin', 'conda');
            if ~exist(conda_path_, 'file')
                errid = 'conda:invalid_conda_path';
                error('%s:No valid conda found at "%s"', errid, conda_path_);
            end
            conda_path = varargin{1};
        end
    case 'activate'
        conda_env = varargin{1};
        conda_py = fullfile(conda_path, 'envs', conda_env, 'bin', 'python');
        pyversion(conda_py);
    otherwise
        args = strjoin({cmd varargin{:}});
        system([fullfile(conda_path, 'bin', 'conda') ' ' args]); 
end

end % function conda

function install(conda_prefix, py3)
    if nargin < 2
        py3 = 1;
    end
    base = 'https://repo.continuum.io/miniconda/';
    plat_map.GLNXA64 = 'Linux-x86_64.sh';
    mc = 'Miniconda';
    if py3
        mc = [mc '3'];
    end
    inst = sprintf('%s-latest-%s', mc, plat_map.(computer));
    if ~exist(inst, 'file')
        conda_inst_path = websave(inst, [base inst]);
    else
        conda_inst_path = inst;
    end
    system(sprintf('bash %s -b -p %s', conda_inst_path, conda_prefix));
end
