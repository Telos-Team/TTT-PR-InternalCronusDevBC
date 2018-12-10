codeunit 50016 "TTTPR AzureStorageDownload"
{
    trigger OnRun()
    begin
        //DownloadSimpleFile();
        //DownloadLargeFilePortion();
        GetFileSize();
    end;

    var
        myInt: Integer;

    local procedure DownloadSimpleFile()
    var
        loctxtUrl: Text;
        lochttpClt: HttpClient;
        lochttpReq: HttpRequestMessage;
        lochttpResp: HttpResponseMessage;
        lochttpContent: HttpContent;
        lochttpHeaders: HttpHeaders;

        locstrmIn: InStream;
        locbooOk: Boolean;
        loctxtRead: Text;
        loctxtReadLast: Text;
        locintCount: Integer;
        arr: array[100] of Text;

    begin
        loctxtUrl := 'https://tttprpublicstorage.blob.core.windows.net/tttprblobcontainer/NAV2BC.txt';

        Message('Downloading Azure Blob');
        lochttpReq.Method('GET');
        lochttpReq.SetRequestUri(loctxtUrl);
        locbooOk := lochttpClt.Send(lochttpReq, lochttpResp);
        messagE('Send: %1', locbooOk);
        messagE('%1\%2\%3', lochttpResp.HttpStatusCode(), lochttpResp.IsSuccessStatusCode(), lochttpResp.ReasonPhrase());

        // Content headers
        lochttpContent := lochttpResp.Content();
        locboook := lochttpContent.GetHeaders(lochttpHeaders);
        Message('Content Headers\%1', lochttpHeaders);
        if lochttpHeaders.Contains('Content-Length') then begin
            lochttpHeaders.GetValues('Content-Length', arr);
            Message('Content-Length\%1', arr[1]);
        end;

        locboook := lochttpContent.ReadAs(locstrmIn);
        while locstrmIn.ReadText(loctxtRead) > 0 do begin
            loctxtReadLast := loctxtRead;
            locintCount += 1;
            ;
        end;
        Message('%1, %2', locintCount, loctxtReadLast);
    end;

    local procedure DownloadLargeFilePortion()
    var
        loctxtUrl: Text;
        lochttpClt: HttpClient;
        lochttpReq: HttpRequestMessage;
        lochttpResp: HttpResponseMessage;
        lochttpContent: HttpContent;
        lochttpHeaders: HttpHeaders;

        locstrmIn: InStream;
        locbooOk: Boolean;
        loctxtRead: Text;
        loctxtReadLast: Text;
        locintCount: Integer;
        locdurTimeout: Duration;
        arr: array[10] of Text;

    begin
        loctxtUrl := 'https://tttprpublicstorage.blob.core.windows.net/tttprblobcontainer/NAV2BC_Hummels.txt';
        locdurTimeout := 1000 * 60 * 5;

        Message('Downloading Azure Blob');
        lochttpReq.Method('GET');
        lochttpReq.SetRequestUri(loctxtUrl);
        // Request Headers
        lochttpReq.GetHeaders(lochttpHeaders);
        lochttpHeaders.Add('x-ms-range', 'bytes=0-9999999');

        lochttpClt.Timeout(locdurTimeout);
        locbooOk := lochttpClt.Send(lochttpReq, lochttpResp);
        messagE('Send: %1', locbooOk);
        messagE('%1\%2\%3', lochttpResp.HttpStatusCode(), lochttpResp.IsSuccessStatusCode(), lochttpResp.ReasonPhrase());

        // Response headers
        lochttpHeaders := lochttpResp.Headers();
        Message('Response Headers\%1', lochttpHeaders);

        // Content headers
        lochttpContent := lochttpResp.Content();
        locboook := lochttpContent.GetHeaders(lochttpHeaders);
        Message('Content Headers\%1', lochttpHeaders);
        if lochttpHeaders.Contains('Content-Length') then begin
            lochttpHeaders.GetValues('Content-Length', arr);
            Message('Content-Length\%1', arr[1]);
        end;

        locboook := lochttpContent.ReadAs(locstrmIn);
        while locstrmIn.ReadText(loctxtRead) > 0 do begin
            loctxtReadLast := loctxtRead;
            locintCount += 1;
            ;
        end;
        Message('%1, %2', locintCount, loctxtReadLast);
    end;

    local procedure GetFileSize()
    var
        lochttpClt: HttpClient;
        lochttpReq: HttpRequestMessage;
        lochttpResp: HttpResponseMessage;
        lochttpContent: HttpContent;
        lochttpHeaders: HttpHeaders;
        locstrmIn: InStream;
        locbooOk: Boolean;
        locintCount: Integer;
        loctxtUrl: Text;
        loctxtFilename: Text;
        loctxtRead: Text;
        arr: array[10] of Text;

    begin
        loctxtUrl := 'https://tttprpublicstorage.blob.core.windows.net/tttprblobcontainer/NAV2BC_Hummels.txt';

        for locintCount := StrLen(loctxtUrl) downto 1 do
            if CopyStr(loctxtUrl, locintCount, 1) = '/' then begin
                loctxtFilename := CopyStr(loctxtUrl, locintCount + 1);
                loctxtUrl := CopyStr(loctxtUrl, 1, locintCount);
                locintCount := 0;
            end;
        loctxtUrl += '?restype=container&comp=list';
        loctxtUrl += StrSubstNo('&prefix=%1', loctxtFilename);

        Message('Downloading Azure Blob');
        lochttpReq.Method('GET');
        lochttpReq.SetRequestUri(loctxtUrl);

        locbooOk := lochttpClt.Send(lochttpReq, lochttpResp);
        Message('Send: %1', locbooOk);
        Message('%1\%2\%3', lochttpResp.HttpStatusCode(), lochttpResp.IsSuccessStatusCode(), lochttpResp.ReasonPhrase());
        Message(loctxtUrl);

        // Content headers
        lochttpContent := lochttpResp.Content();
        locboook := lochttpContent.GetHeaders(lochttpHeaders);
        Message('Content Headers\%1', lochttpHeaders);
        if lochttpHeaders.Contains('Content-Length') then begin
            lochttpHeaders.GetValues('Content-Length', arr);
            Message('Content-Length\%1', arr[1]);
        end;

        locboook := lochttpContent.ReadAs(locstrmIn);
        locstrmIn.ReadText(loctxtRead);
        Message(loctxtRead);
    end;
}