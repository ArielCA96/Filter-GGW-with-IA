function CstExportSparametersTXT2(mws, exportpath)

SelectTreeItem = invoke(mws,'SelectTreeItem','1D Results\S-Parameters');
ASCIIExport = invoke(mws,'ASCIIExport');
invoke(ASCIIExport,'Reset');
invoke(ASCIIExport,'SetVersion','2010');
invoke(ASCIIExport,'FileName',exportpath);
invoke(ASCIIExport,'Execute');

end
