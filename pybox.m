function pybox(cmd, varargin)
% Handle Python environments using Continuum's conda & PyPI pip

% TODO
% 
% - install to userpath/conda
% - don't shadow conda's commands
% - make it stupid simple to get started quickly

conda_path = fullfile(fileparts(which(mfilename)), 'conda');

switch cmd
    % TODO this prevents true conda install from working.
    case 'install_conda'
        install();
    case 'use'
        pyversion(fullfile(conda_path, 'bin', 'python'));
    otherwise
        args = strjoin({cmd varargin{:}});
        system([fullfile(conda_path, 'bin', 'conda') ' ' args]); 
end

end % function conda

function install(conda_prefix, py3)
    % default to install within pybox directory
    if nargin < 1
        conda_prefix = fileparts(which(mfilename));
    end
    % default to Python 3 version of conda
    if nargin < 2, py3 = 1; end
    % check conda not already installed (TODO offer overwrite option)
    conda_dir = fullfile(conda_prefix, 'conda');
    if exist(conda_dir, 'dir')
        errid = 'pybox:conda_dir_exists:Conda already installed!';
        error(errid);
    end
    % form installer name and url
    base = 'https://repo.continuum.io/miniconda/';
    plat_map.GLNXA64 = 'Linux-x86_64.sh';
    plat_map.PCWIN64 = 'Windows-x86_64.sh';
    plat_map.PCWIN = 'Windows-x86.sh';
    plat_map.MACI64 = 'MacOSX-x86_64.sh';
    mc = 'Miniconda';
    if py3
        mc = [mc '3'];
    end
    inst = sprintf('%s-latest-%s', mc, plat_map.(computer));
    inst_path = fullfile(conda_prefix, inst);
    % download if necessary
    if ~exist(inst, 'file')
        inst_path = websave(inst_path, [base inst]);
    end
    % run installer
    system(sprintf('bash %s -b -p %s', inst_path, conda_dir));
end