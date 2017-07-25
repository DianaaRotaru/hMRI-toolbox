function crm = tbx_scfg_hmri_create
% Configuration file for the "histological MRI" (hMRI) toolbox
% Previously named "Voxel-Based Quantification" (VBQ)
% -> Dealing with the creation of the maps
%_______________________________________________________________________
% Copyright (C) 2014 Wellcome Trust Centre for Neuroimaging

% Christophe Phillips

b1_choices = hmri_get_defaults('b1_type.labels');

% ---------------------------------------------------------------------
% raws Raw Images
% ---------------------------------------------------------------------
raws3           = cfg_files;
raws3.tag       = 'T1';
raws3.name      = 'T1 images';
raws3.help      = {'Input T1 images.'};
raws3.filter    = 'image';
raws3.ufilter   = '.*';
raws3.num       = [0 Inf];
raws3.val       = {''};
% ---------------------------------------------------------------------
% raws Raw Images
% ---------------------------------------------------------------------
raws2           = cfg_files;
raws2.tag       = 'PD';
raws2.name      = 'PD images';
raws2.help      = {'Input PD images.'};
raws2.filter    = 'image';
raws2.ufilter   = '.*';
raws2.num       = [0 Inf];
raws2.val       = {''};
% ---------------------------------------------------------------------
% raws Raw Images
% ---------------------------------------------------------------------
raws1           = cfg_files;
raws1.tag       = 'MT';
raws1.name      = 'MT images';
raws1.help      = {'Input MT images.'};
raws1.filter    = 'image';
raws1.ufilter   = '.*';
raws1.num       = [0 Inf];
raws1.val       = {''};
% ---------------------------------------------------------------------
% vols Volumes
% ---------------------------------------------------------------------
raws            = cfg_branch;
raws.tag        = 'raw_mpm';
raws.name       = 'Raw multiparameter data';
raws.help       = {'Input all the MT/PD/T1-weighted images.'};
raws.val        = {raws1 raws2 raws3 };


%--------------------------------------------------------------------------
% B1 acq/proc defaults file
%--------------------------------------------------------------------------
b1defaults         = cfg_files;
b1defaults.tag     = 'b1defaults';
b1defaults.name    = 'B1 defaults file';
b1defaults.help    = {['Select the ''hmri_b1_defaults*.m'' file containing ' ...
    'the parameters for processing the B1 map data. By default, parameters will be ' ...
    'collected from metadata when available. Defaults parameters are provided as ' ...
    'fallback solution when metadata are not available and/or uncomplete.'], ...
    ['Please make sure that the parameters defined in the defaults file ' ...
    'are correct for your data. To create your own customised defaults file, ' ...
    'either edit the distributed version and/or save it with the name ' ...
    '''hmri_b1_defaults_*yourprotocol*.m''.']};
b1defaults.filter  = 'm';
b1defaults.dir     = fileparts(mfilename('fullpath'));
b1defaults.ufilter = '^hmri_b1_defaults.*\.m$';
b1defaults.num     = [1 1];
b1defaults.def     = @(val)hmri_get_defaults('b1map.i3D_EPI.deffnam', val{:});

% ---------------------------------------------------------------------
% UNICORT B1 bias correction
% ---------------------------------------------------------------------
b1metadata           = cfg_entry;
b1metadata.tag       = 'b1metadata';
b1metadata.name      = 'Use metadata or standard defaults.';
b1metadata.help      = {''};
b1metadata.strtype = 's';
b1metadata.num     = [1 Inf];
b1metadata.val     = {'Defaults'};

%--------------------------------------------------------------------------
% B1 processing parameters
%--------------------------------------------------------------------------
b1parameters         = cfg_choice;
b1parameters.tag     = 'b1parameters';
b1parameters.name    = 'B1 processing parameters';
b1parameters.help    = {['You can either stick with metadata and standard ' ...
    'defaults parameters (recommended) or select your own customised defaults file ' ...
    '(fallback for situations where no metadata are available).']};
b1parameters.values  = {b1metadata b1defaults};
b1parameters.val     = {b1metadata};


% ---------------------------------------------------------------------
% B1 input images 
% ---------------------------------------------------------------------
b1raw          = cfg_files;
b1raw.tag      = 'b1';
b1raw.name     = 'B1 images';
b1raw.help     = {
    'Select B1 input images according to the type of B1 bias correction.'
    };
b1raw.filter   = 'image';
b1raw.ufilter  = '.*';
b1raw.num      = [2 30];
b1raw.val      = {''};

% ---------------------------------------------------------------------
% B0 input images
% ---------------------------------------------------------------------
b0raw          = cfg_files;
b0raw.tag      = 'b0raw';
b0raw.name     = 'B0 images';
b0raw.help     = {'Select B0 images.' ...
    'Only required for distortion correction of EPI-based B1 maps.' ...
    'Select both magnitude images and the presubtracted phase image, in that order.'};
b0raw.filter   = 'image';
b0raw.ufilter  = '.*';
b0raw.num      = [3 3];
b0raw.val      = {''};

% ---------------------------------------------------------------------
% UNICORT B1 bias correction
% ---------------------------------------------------------------------
b1_input_UNICORT           = cfg_entry;
b1_input_UNICORT.tag       = 'b1_input_UNICORT';
b1_input_UNICORT.name      = 'UNICORT';
b1_input_UNICORT.help      = {'UNICORT will be applied for B1 bias correction.'
    'No B1 input data required.'};
b1_input_UNICORT.strtype = 's';
b1_input_UNICORT.num     = [1 Inf];
b1_input_UNICORT.val     = {'done'};


% ---------------------------------------------------------------------
% No B1 bias correction
% ---------------------------------------------------------------------
b1_input_noB1           = cfg_entry;
b1_input_noB1.tag       = 'b1_input_noB1';
b1_input_noB1.name      = 'no_B1_correction';
b1_input_noB1.help      = {['No B1 bias correction will be applied. Note that ' ...
    'when no B1 map is available, UNICORT might be a better ' ...
    'solution than no B1 bias correction at all.']};
b1_input_noB1.strtype = 's';
b1_input_noB1.num     = [1 Inf];
b1_input_noB1.val     = {'done'};


% ---------------------------------------------------------------------
% RF_MAP B1 protocol
% ---------------------------------------------------------------------
b1_input_preproc           = cfg_branch;
b1_input_preproc.tag       = 'b1_input_preproc';
b1_input_preproc.name      = 'pre_processed_B1';
b1_input_preproc.help      = {'Input pre-calculated B1 bias map.'
    ['Please select one unprocessed magnitude image ' ...
    'from the B1map data set (for coregistration with the multiparameter maps) ' ...
    'and the preprocessed B1map (in percent units), in that order.']};
b1_input_preproc.val       = {b1raw};


% ---------------------------------------------------------------------
% RF_MAP B1 protocol
% ---------------------------------------------------------------------
b1_input_rfmap           = cfg_branch;
b1_input_rfmap.tag       = 'b1_input_rfmap';
b1_input_rfmap.name      = 'rf_map';
b1_input_rfmap.help      = {'Input B1 images for rf_map B1 map protocol.' ...
    'As B1 map input, please select the pair of anatomical and precalcuated B1 map.'};
b1_input_rfmap.val       = {b1raw};


% ---------------------------------------------------------------------
% TFL_B1_MAP B1 protocol
% ---------------------------------------------------------------------
b1_input_tfl           = cfg_branch;
b1_input_tfl.tag       = 'b1_input_tfl';
b1_input_tfl.name      = 'tfl_b1_map';
b1_input_tfl.help      = {'Input B1 data for TFL B1 map protocol.' ...
    'As B1 map input, please select the pair of anatomical and precalculated B1 map.'};
b1_input_tfl.val       = {b1raw};


% ---------------------------------------------------------------------
% i3D_AFI B1 protocol
% ---------------------------------------------------------------------
b1_input_3DAFI           = cfg_branch;
b1_input_3DAFI.tag       = 'b1_input_3DAFI';
b1_input_3DAFI.name      = 'i3D_AFI';
b1_input_3DAFI.help      = {'3D AFI protocol.', ...
    'As B1 map input, please select a TR2/TR1 pair of magnitude images.', ...
    ['Acquisition and processing parameters can be retrieved through ' ...
    'either of the three following methods:'], ...
    '- using the metadata available with the nifti files (recommended),', ...
    '- using defaults parameters available in hmri_defaults.m,', ...
    '- loading customized defaults from a selected hmri_b1_defaults_*.m file'};
b1_input_3DAFI.val       = {b1raw b1parameters};


% ---------------------------------------------------------------------
% i3D_EPI B1 protocol
% ---------------------------------------------------------------------
b1_input_3DEPI           = cfg_branch;
b1_input_3DEPI.tag       = 'b1_input_3DEPI';
b1_input_3DEPI.name      = 'i3D_EPI';
b1_input_3DEPI.help      = {'Input B0/B1 data for 3D EPI protocol'
    'For B1 data, please select all pairs of SE/STE 3D EPI images.'
    ['For this EPI protocol, it is recommended to acquire B0 field map data ' ...
    'for distortion correction. If no B0 map available, the script will proceed ' ...
    'with distorted images.']
    ['Please enter the two magnitude images and the presubtracted phase image' ...
    'from the B0 mapping acquisition, in that order.']
    ['Moreover, acquisition and processing parameters can be retrieved through ' ...
    'either of the three following methods:']
    '- using the metadata available with the nifti files (recommended),'
    '- using defaults parameters available in hmri_defaults.m,'
    '- loading customized defaults from a selected hmri_b1_defaults_*.m file'};
b1_input_3DEPI.val       = {b1raw b0raw b1parameters};


% ---------------------------------------------------------------------
% menu type_b1
% ---------------------------------------------------------------------
b1_type         = cfg_choice;
b1_type.tag     = 'b1_type';
b1_type.name    = 'B1 bias correction';
b1_type.help    = {'Choose the B1 map type.'
    ['Various B1map types can be handled by the hMRI ' ...
    'toolbox when creating the multiparameter maps. See list below for a ' ...
    'brief description of each type. Note that all types may not be ' ...
    'available at your site.']
    [' - i3D_EPI: B1map obtained from spin echo (SE) and stimulated echo ' ...
    '(STE) images recorded with a 3D EPI scheme [Lutti A et al., ' ...
    'PLoS One 2012;7(3):e32379].']
    [' - i3D_AFI: 3D actual flip angle imaging (AFI) method based on [Yarnykh VL, ' ...
    'Magn Reson Med 2007;57:192-200].']
    [' - tfl_b1_map: Siemens product sequence for B1 mapping based on turbo FLASH.']
    [' - rf_map: Siemens product sequence for B1 mapping based on SE/STE.']
    [' - no_B1_correction: if selected no B1 bias correction will be applied.']
    [' - pre_processed_B1: B1 map pre-calculated out of the hMRI toolbox, must ' ...
    'be expressed in percent units of the nominal flip angle value (percent bias).']
    [' - UNICORT: Use this option when B1 maps not available. ' ...
    'Bias field estimation and correction will be performed ' ...
    'using the approach described in [Weiskopf et al., NeuroImage 2011; 54:2116-2124].']
    }; %#ok<*NBRAK>
% b1_type.labels  = {'i3D_EPI','i3D_AFI','tfl_b1_map','rf_map','no_B1_correction','pre_processed_B1','UNICORT'};
b1_type.values  = {b1_input_3DEPI b1_input_3DAFI b1_input_tfl b1_input_rfmap b1_input_noB1 b1_input_preproc b1_input_UNICORT};
b1_type.val     = {b1_input_3DEPI};

% ---------------------------------------------------------------------
% vols Volumes
% ---------------------------------------------------------------------
sraws3MT          = cfg_files;
sraws3MT.tag      = 'raw_sens_MT';
sraws3MT.name     = 'MT coil sensitivity';
sraws3MT.help     = {'Input low resolution images for MT-weighted images', ...
    'acquired with the head and body coil in this order.'};
sraws3MT.filter   = 'image';
sraws3MT.ufilter  = '.*';
sraws3MT.num      = [2 2];
% ---------------------------------------------------------------------
% vols Volumes
% ---------------------------------------------------------------------
sraws3PD          = cfg_files;
sraws3PD.tag      = 'raw_sens_PD';
sraws3PD.name     = 'PD coil sensitivity';
sraws3PD.help     = {'Input low resolution images for PD-weighted images', ...
    'acquired with the head and body coil in this order.'};
sraws3PD.filter   = 'image';
sraws3PD.ufilter  = '.*';
sraws3PD.num      = [2 2];
% ---------------------------------------------------------------------
% vols Volumes
% ---------------------------------------------------------------------
sraws3T1          = cfg_files;
sraws3T1.tag      = 'raw_sens_T1';
sraws3T1.name     = 'T1 coil sensitivity';
sraws3T1.help     = {'Input low resolution images for T1-weighed images', ...
    'acquired with the head and body coil in this order.'};
sraws3T1.filter   = 'image';
sraws3T1.ufilter  = '.*';
sraws3T1.num      = [2 2];
% ---------------------------------------------------------------------
% vols Volumes
% ---------------------------------------------------------------------
sraws3           = cfg_branch;
sraws3.tag       = 'raw_sens3';
sraws3.name      = 'Raw low resolution coil sensitivity data';
sraws3.help      = {'Input low resolution images for each contrast weighting', ...
    'acquired with the head and body coil in this order.'};
sraws3.val       = {sraws3MT sraws3PD sraws3T1};
% ---------------------------------------------------------------------
% x0 No RF sensitivity
% ---------------------------------------------------------------------
x0         = cfg_menu;
x0.tag     = 'RF_none';
x0.name    = 'RF sensitivity not acquired';
x0.help    = {'Choose this option, if no RF sensitivity was acquired.'};
x0.labels = {''};
x0.values = {1};
x0.val = {1};
% ---------------------------------------------------------------------
% x1 RF sensitivity acquired once 
% ---------------------------------------------------------------------
x1         = cfg_files;
x1.tag     = 'RF_once';
x1.name    = 'RF sensitivity acquired once';
%x1.help    = {'Choose this option, if RF sensitivity was acquired once per subject.'};
x1.help      = {'Input low resolution images for RF sensitivity', ...
    'acquired with the head and body coil in this order.'};
x1.filter   = 'image';
x1.ufilter  = '.*';
x1.num      = [2 2];
% ---------------------------------------------------------------------
% x3 RF sensitivity acquired for each modality 
% ---------------------------------------------------------------------
x3         = cfg_branch;
x3.tag     = 'RF_MPM';
x3.name    = 'RF sensitivity acquired for each contrast weighting';
x3.help    = {'Choose this option, if RF sensitivity was acquired ',...
    'for each contrast weighting, i.e. for T1-, PD- and MT-weighted images.'};
x3.val  = {sraws3};
% ---------------------------------------------------------------------
% sensitivity Sensitivity choice
% ---------------------------------------------------------------------
sensitivity         = cfg_choice;
sensitivity.tag     = 'sensitivity';
sensitivity.name    = 'RF sensitivity';
sensitivity.help    = {'Specify the kind of RF sensitivity acquired. ',...
    'Could be none, once or per contrast weighting.'};
sensitivity.values  = {x0 x1 x3};
sensitivity.val = {x0};
% ---------------------------------------------------------------------
% subj Subject
% ---------------------------------------------------------------------
subj            = cfg_branch;
subj.tag        = 'subj';
subj.name       = 'Subject';
subj.val        = {b1_type raws };
subj.help       = {'Specify a subject for maps calculation.'};
% ---------------------------------------------------------------------
% data Data
% ---------------------------------------------------------------------
sdata           = cfg_repeat;
sdata.tag       = 'data';
sdata.name      = 'Few Subjects';
sdata.val       = {subj };
sdata.help      = {'Specify the number of subjects.'};
sdata.values    = {subj };
sdata.num       = [1 Inf];
% ---------------------------------------------------------------------
% indir Input directory as output directory
% ---------------------------------------------------------------------
indir         = cfg_entry;
indir.tag     = 'indir';
indir.name    = 'Input directory';
indir.help    = {'Output files will be written to the same folder ',...
    'as each corresponding input file.'};
indir.strtype = 's';
indir.num     = [1 Inf];
indir.val     = {'yes'};
% ---------------------------------------------------------------------
% outdir Output directory
% ---------------------------------------------------------------------
outdir         = cfg_files;
outdir.tag     = 'outdir';
outdir.name    = 'Output directory';
outdir.help    = {'Select a directory where output files will be written to.'};
outdir.filter = 'dir';
outdir.ufilter = '.*';
outdir.num     = [1 1];
% ---------------------------------------------------------------------
% output Output choice
% ---------------------------------------------------------------------
output         = cfg_choice;
output.tag     = 'output';
output.name    = 'Output choice';
output.help    = {'Output directory can be the same as the input ',...
    'directory for each input file or user selected'};
output.values  = {indir outdir };
output.val = {indir};
% ---------------------------------------------------------------------
% sdata_multi
% ---------------------------------------------------------------------
sdata_multi = cfg_branch;
sdata_multi.name = 'Many Subjects';
sdata_multi.tag = 'sdata_multi';
sdata_multi.help = {'Specify data with many subjects.'};
% ---------------------------------------------------------------------
% data_spec
% ---------------------------------------------------------------------
data_spec = cfg_choice;
data_spec.name = 'Data Specification Method';
data_spec.tag = 'data_spec';
data_spec.values = { sdata sdata_multi };
data_spec.val = { sdata };
data_spec.help = {'Specify data with either few or many subjects. The ',...
    'latter can be used with SmartDep toolbox.'};
% ---------------------------------------------------------------------
% create_mpr Create MPR maps (whether B0/B1 maps are available or not)
% ---------------------------------------------------------------------
create_mpr         = cfg_exbranch;
create_mpr.tag     = 'create_mpr';
create_mpr.name    = 'Multiparameter maps';
raws.val        = {raws1 raws2 raws3 };
subj.val        = {output sensitivity b1_type raws};
sdata.val       = {subj };
sdata.values    = {subj };
sdata_multi.val  = { output unlimit(b1_type) unlimit(raws) };
data_spec.values = { sdata sdata_multi };
data_spec.val    = { sdata };
create_mpr.val     = { data_spec };
create_mpr.help    = {'hMRI map creation can handle data sets with and without B0/B1 maps.'};
create_mpr.prog    = @hmri_run_create;
create_mpr.vout    = @vout_create;
% ---------------------------------------------------------------------
% crm Create maps
% ---------------------------------------------------------------------
crm             = cfg_choice;
crm.tag         = 'crm';
crm.name        = 'Create maps';
crm.help        = {'You have the option to create multiparameter maps, ',...
    'whether B1 maps are available or not.'};
crm.values      = {create_mpr};

end
%----------------------------------------------------------------------

% ========================================================================
%% VOUT & OTHER SUBFUNCTIONS
% ========================================================================
% The RUN function:
% - out = hmri_run_create(job)
% is defined separately.
%_______________________________________________________________________

function dep = vout_create(job)
% This depends on job contents, which may not be present when virtual
% outputs are calculated.

if ~isfield(job, 'subj') % Many subjects
    dep(1) = cfg_dep;
    dep(1).sname = 'R1 Maps';
    dep(1).src_output = substruct('.','R1','()',{':'});
    dep(1).tgt_spec = cfg_findspec({{'filter','image','strtype','e'}});
    
    dep(2) = cfg_dep;
    dep(2).sname = 'R2s Maps';
    dep(2).src_output = substruct('.','R2s','()',{':'});
    dep(2).tgt_spec = cfg_findspec({{'filter','image','strtype','e'}});
    
    dep(3) = cfg_dep;
    dep(3).sname = 'MT Maps';
    dep(3).src_output = substruct('.','MT','()',{':'});
    dep(3).tgt_spec = cfg_findspec({{'filter','image','strtype','e'}});
    
    dep(4) = cfg_dep;
    dep(4).sname = 'A Maps';
    dep(4).src_output = substruct('.','A','()',{':'});
    dep(4).tgt_spec = cfg_findspec({{'filter','image','strtype','e'}});
    
    dep(5) = cfg_dep;
    dep(5).sname = 'T1w Maps';
    dep(5).src_output = substruct('.','T1w','()',{':'});
    dep(5).tgt_spec = cfg_findspec({{'filter','image','strtype','e'}});
    
else
    k=1;
    cdep(5*numel(job.subj),1) = cfg_dep;
    for i=1:numel(job.subj)
        
        cdep(k)            = cfg_dep;
        cdep(k).sname      = sprintf('R1_subj%d',i);
        cdep(k).src_output = substruct('.','subj','()',{i},'.','R1','()',{':'});
        cdep(k).tgt_spec   = cfg_findspec({{'filter','image','strtype','e'}});
        
        k=k+1;
        
        cdep(k)            = cfg_dep;
        cdep(k).sname      = sprintf('R2s_subj%d',i);
        cdep(k).src_output = substruct('.','subj','()',{i},'.','R2s','()',{':'});
        cdep(k).tgt_spec   = cfg_findspec({{'filter','image','strtype','e'}});
        
        k=k+1;
        
        cdep(k)            = cfg_dep;
        cdep(k).sname      = sprintf('MT_subj%d',i);
        cdep(k).src_output = substruct('.','subj','()',{i},'.','MT','()',{':'});
        cdep(k).tgt_spec   = cfg_findspec({{'filter','image','strtype','e'}});
        
        k=k+1;
        
        cdep(k)            = cfg_dep;
        cdep(k).sname      = sprintf('A_subj%d',i);
        cdep(k).src_output = substruct('.','subj','()',{i},'.','A','()',{':'});
        cdep(k).tgt_spec   = cfg_findspec({{'filter','image','strtype','e'}});
        
        k=k+1;
        
        cdep(k)            = cfg_dep;
        cdep(k).sname      = sprintf('T1w_subj%d',i);
        cdep(k).src_output = substruct('.','subj','()',{i},'.','T1w','()',{':'});
        cdep(k).tgt_spec   = cfg_findspec({{'filter','image','strtype','e'}});
        
        k=k+1;
    end
    dep = cdep;
    
end
end
%_______________________________________________________________________




%%%%%%%%%%%%%%%%%%%%
function c = unlimit(c)
try
    if isa(c, 'cfg_files')
        c.num = [0 Inf];
    end
catch e %#ok<*NASGU>
end
try
    for i=1:numel(c.val)
        c.val{i} = unlimit(c.val{i});
    end
catch e
end
end
%_______________________________________________________________________
