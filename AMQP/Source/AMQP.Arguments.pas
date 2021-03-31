{$I AMQP.Options.inc}
unit AMQP.Arguments;

interface

Const
  AMQP_TTL_SECOND = 1000;
  AMQP_TTL_MINUTE = AMQP_TTL_SECOND * 60;
  AMQP_TTL_HOUR   = AMQP_TTL_MINUTE * 60;
  AMQP_TTL_DAY    = AMQP_TTL_HOUR   * 24;

Type
  TArgument = Record
    Name: String;
    Value: Variant;
  End;

  TArguments = Array of TArgument;
  TQueueMode = (qmDefault, qmLazy);

  { TArgumentHelper }

  TArgumentHelper = Record Helper for TArguments
  private
    const CQueueMode: array[TQueueMode] of String = ('default', 'lazy');
  public
    Function Add( Name: String; Value: Variant ): TArguments;
    {$IFNDEF FPC}
    Function SetMessageTTL( TimeToLiveMS: Int64 ): TArguments;
    Function SetXMatchAll: TArguments;
    Function SetXMatchAny: TArguments;
    {$ENDIF}
    Function AddXMatchAll: TArguments;
    Function AddXMatchAny: TArguments;
    Function AddXMessageTTL( TimeToLiveMS: Int64 ): TArguments;
    {$IFNDEF FPC}
    Function SetXQueueMode(AMode: TQueueMode): TArguments;
    {$ENDIF}
    Function AddXQueueMode(AMode: TQueueMode): TArguments;
  End;

function MakeArgument( Name: String; Value: Variant): TArgument;

{$IFNDEF FPC}
Function MakeArguments: TArguments; overload;
Function MakeArguments( Name: String; Value: Variant ): TArguments; overload;
{$ELSE}
Function MakeArguments: TArguments;
{$ENDIF}
implementation

function MakeArgument( Name: String; Value: Variant): TArgument;
begin
 Result.Value:= Value;
 Result.Name:= Name;
end;

{$IFNDEF FPC}
Function MakeArguments( Name: String; Value: Variant ): TArguments;
var
  Arg: TArgument;
Begin
  Arg := MakeArgument(Name, Value);
  Result := [ Arg ];
End;

Function MakeArguments: TArguments;
Begin
  Result := [];
End;
{$ELSE}
function MakeArguments: TArguments;
var
  ar : TArguments;
begin
  SetLength(ar, 0);
  Result := ar;
end;
{$ENDIF}

{ TArgumentHelper }

function TArgumentHelper.Add(Name: String; Value: Variant): TArguments;
begin
  {$IFDEF FPC}
  SetLength(Self, Length(Self) + 1);
  Self[Length(Self)] := MakeArgument(Name, Value);
  Result := Self;
  {$ELSE}
  Result := self + MakeArguments( Name, Value );
  {$ENDIF}
end;

function TArgumentHelper.AddXMatchAll: TArguments;
begin
  {$IFDEF FPC}
  Result := Self.Add('x-match', 'all');
  {$ELSE}
  Result := Self + SetXMatchAll;
  {$ENDIF}
end;

function TArgumentHelper.AddXMatchAny: TArguments;
begin
  {$IFDEF FPC}
  Result := Self.Add('x-match', 'any');
  {$ELSE}
  Result := Self + SetXMatchAny;
  {$ENDIF}
end;

function TArgumentHelper.AddXMessageTTL(TimeToLiveMS: Int64): TArguments;
begin
  {$IFDEF FPC}
  Result := Self.Add('x-message-ttl', TimeToLiveMS);
  {$ELSE}
  Result := Self + SetMessageTTL(TimeToLiveMS);
  {$ENDIF}
end;

function TArgumentHelper.AddXQueueMode(AMode: TQueueMode): TArguments;
begin
  {$IFDEF FPC}
  Result := Self.Add('x-queue-mode',  CQueueMode[AMode]);
  {$ELSE}
  Result := Self + SetXQueueMode(AMode);
  {$ENDIF}
end;

{$IFNDEF FPC}
function TArgumentHelper.SetMessageTTL(TimeToLiveMS: Int64): TArguments;
begin
  Result := MakeArguments( 'x-message-ttl', TimeToLiveMS );
end;

function TArgumentHelper.SetXMatchAll: TArguments;
begin
  Result := MakeArguments('x-match', 'all');
end;

function TArgumentHelper.SetXMatchAny: TArguments;
begin
 Result := MakeArguments('x-match', 'any');
end;

function TArgumentHelper.SetXQueueMode(AMode: TQueueMode): TArguments;
begin
  Result := MakeArguments('x-queue-mode', CQueueMode[AMode]);
end;
{$ENDIF}

end.
