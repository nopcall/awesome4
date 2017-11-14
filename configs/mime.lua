local xdg_mime = function (prg)
    local desktop = prg .. ".desktop"
    local cmd = {
        "xdg-mime default " ..
            desktop ..
            " `grep 'MimeType=' /usr/share/applications/" ..
            desktop ..
            " | sed -e 's/.*=//' -e 's/;/ /g'` ",}
    os.execute(table.concat(cmd, ";"))
end

xdg_mime(context.guitools.browser)
xdg_mime(context.guitools.picviewer)
xdg_mime(context.guitools.pdfviewer)
xdg_mime(context.guitools.videoplayer)
xdg_mime(context.guitools.filemanager)
