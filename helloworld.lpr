program helloworld;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, CustApp
  { you can add sunits after this };



type
  { THelloWorldApplication }

  THelloWorldApplication = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ THelloWorldApplication }

procedure THelloWorldApplication.DoRun;
var
  ErrorMsg: String;
  input_msg:string;
begin

  // quick check parameters
  ErrorMsg:=CheckOptions('h', 'help');
  if ErrorMsg<>'' then begin
    ShowException(Exception.Create(ErrorMsg));
    Terminate;
    Exit;
  end;

  // parse parameters
  if HasOption('h', 'help') then begin
    WriteHelp;
    Terminate;
    Exit;
  end;
  ReadLn(Input,input_msg);

  { add your program here }
  if input_msg <> 'exit' then
  begin
     WriteLn('HelloWorld '+ input_msg);
  end;

  if (input_msg = 'exit') then
  begin
  // stop program loop
  Terminate;
  end;
end;

constructor THelloWorldApplication.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor THelloWorldApplication.Destroy;
begin
  inherited Destroy;
end;

procedure THelloWorldApplication.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
end;

var
  Application: THelloWorldApplication;
begin
  Application:=THelloWorldApplication.Create(nil);
  Application.Title:='HelloWorldApplication';
  Application.Run;
  Application.Free;
end.

