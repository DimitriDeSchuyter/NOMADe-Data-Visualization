import classes.*
addpath( 'functions')
m = measurement();

m = m.connect('ID','ASC');
getList =m.list.id;
for id = 20:numel(getList)
    disp( "******* Start measurement " +getList(id) + " ********")
    m = measurement();
    m = m.connect('ID','ASC');
    m=m.set_measurement_ID(getList(id));
    disp( "******* Declaration ********")
    m = m.declaration("full",0,true);
     disp( "******* Extract and process data ********")
     includedInstruments = zeros(1,m.n_instruments);
    m = m.get_dataset_DB(includedInstruments,true);
    disp( "******* Saving to .mat ********")
    mextracted = m.extractionMobject();
    storeName = strcat('ID',num2str(m.id),'_m-extracted_',datestr(m.start_time,'yyyy_mm_dd_HHMMSS'));
     store = fullfile('H:\5. NOMADe\backups\measurementObjects', [storeName '.mat']);
    warning off backtrace;
    save(store,'mextracted','-v7.3');
    warning on backtrace;
    clearvars -except getList
end