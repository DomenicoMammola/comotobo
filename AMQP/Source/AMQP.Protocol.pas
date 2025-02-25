{$I AMQP.Options.inc}
unit AMQP.Protocol;

interface

Uses
  IdGlobal;

Type
  TAMQPMethodID = Record
    ClassID  : UInt16;
    MethodID : UInt16;
  End;

Const
  {$IFDEF FPC}
  AMQP_Header: array [0.. 7] of Byte = (65, 77, 81, 80, 0, 0, 9, 1); //'AMQP' + #0 + #0 + #9 + #1
  {$ELSE}
  AMQP_Header: TIdBytes = [65, 77, 81, 80, 0, 0, 9, 1]; //'AMQP' + #0 + #0 + #9 + #1
  {$ENDIF}


  AMQP_CLASS_CONNECTION = 10;
  AMQP_CLASS_CHANNEL    = 20;
  AMQP_CLASS_EXCHANGE   = 40;
  AMQP_CLASS_QUEUE      = 50;
  AMQP_CLASS_BASIC      = 60;
  AMQP_CLASS_CONFIRM    = 85;
  AMQP_CLASS_TX         = 90;

  AMQP_CONNECTION_START     : TAMQPMethodID = ( ClassID: AMQP_CLASS_CONNECTION; MethodID: 10 );
  AMQP_CONNECTION_START_OK  : TAMQPMethodID = ( ClassID: AMQP_CLASS_CONNECTION; MethodID: 11 );
  AMQP_CONNECTION_SECURE    : TAMQPMethodID = ( ClassID: AMQP_CLASS_CONNECTION; MethodID: 20 );
  AMQP_CONNECTION_SECURE_OK : TAMQPMethodID = ( ClassID: AMQP_CLASS_CONNECTION; MethodID: 21 );
  AMQP_CONNECTION_TUNE      : TAMQPMethodID = ( ClassID: AMQP_CLASS_CONNECTION; MethodID: 30 );
  AMQP_CONNECTION_TUNE_OK   : TAMQPMethodID = ( ClassID: AMQP_CLASS_CONNECTION; MethodID: 31 );
  AMQP_CONNECTION_OPEN      : TAMQPMethodID = ( ClassID: AMQP_CLASS_CONNECTION; MethodID: 40 );
  AMQP_CONNECTION_OPEN_OK   : TAMQPMethodID = ( ClassID: AMQP_CLASS_CONNECTION; MethodID: 41 );
  AMQP_CONNECTION_CLOSE     : TAMQPMethodID = ( ClassID: AMQP_CLASS_CONNECTION; MethodID: 50 );
  AMQP_CONNECTION_CLOSE_OK  : TAMQPMethodID = ( ClassID: AMQP_CLASS_CONNECTION; MethodID: 51 );

  AMQP_CHANNEL_OPEN         : TAMQPMethodID = ( ClassID: AMQP_CLASS_CHANNEL; MethodID: 10 );
  AMQP_CHANNEL_OPEN_OK      : TAMQPMethodID = ( ClassID: AMQP_CLASS_CHANNEL; MethodID: 11 );
  AMQP_CHANNEL_FLOW         : TAMQPMethodID = ( ClassID: AMQP_CLASS_CHANNEL; MethodID: 20 ); //TODO
  AMQP_CHANNEL_FLOW_OK      : TAMQPMethodID = ( ClassID: AMQP_CLASS_CHANNEL; MethodID: 21 ); //TODO
  AMQP_CHANNEL_CLOSE        : TAMQPMethodID = ( ClassID: AMQP_CLASS_CHANNEL; MethodID: 40 );
  AMQP_CHANNEL_CLOSE_OK     : TAMQPMethodID = ( ClassID: AMQP_CLASS_CHANNEL; MethodID: 41 );

  AMQP_EXCHANGE_DECLARE     : TAMQPMethodID = ( ClassID: AMQP_CLASS_EXCHANGE; MethodID: 10 );
  AMQP_EXCHANGE_DECLARE_OK  : TAMQPMethodID = ( ClassID: AMQP_CLASS_EXCHANGE; MethodID: 11 );
  AMQP_EXCHANGE_DELETE      : TAMQPMethodID = ( ClassID: AMQP_CLASS_EXCHANGE; MethodID: 20 );
  AMQP_EXCHANGE_DELETE_OK   : TAMQPMethodID = ( ClassID: AMQP_CLASS_EXCHANGE; MethodID: 21 );
  AMQP_EXCHANGE_BIND        : TAMQPMethodID = ( ClassID: AMQP_CLASS_EXCHANGE; MethodID: 30 );
  AMQP_EXCHANGE_BIND_OK     : TAMQPMethodID = ( ClassID: AMQP_CLASS_EXCHANGE; MethodID: 31 );
  AMQP_EXCHANGE_UNBIND        : TAMQPMethodID = ( ClassID: AMQP_CLASS_EXCHANGE; MethodID: 40 );
  AMQP_EXCHANGE_UNBIND_OK     : TAMQPMethodID = ( ClassID: AMQP_CLASS_EXCHANGE; MethodID: 51 );

  AMQP_QUEUE_DECLARE        : TAMQPMethodID = ( ClassID: AMQP_CLASS_QUEUE; MethodID: 10 );
  AMQP_QUEUE_DECLARE_OK     : TAMQPMethodID = ( ClassID: AMQP_CLASS_QUEUE; MethodID: 11 );
  AMQP_QUEUE_BIND           : TAMQPMethodID = ( ClassID: AMQP_CLASS_QUEUE; MethodID: 20 );
  AMQP_QUEUE_BIND_OK        : TAMQPMethodID = ( ClassID: AMQP_CLASS_QUEUE; MethodID: 21 );
  AMQP_QUEUE_UNBIND         : TAMQPMethodID = ( ClassID: AMQP_CLASS_QUEUE; MethodID: 50 );
  AMQP_QUEUE_UNBIND_OK      : TAMQPMethodID = ( ClassID: AMQP_CLASS_QUEUE; MethodID: 51 );
  AMQP_QUEUE_PURGE          : TAMQPMethodID = ( ClassID: AMQP_CLASS_QUEUE; MethodID: 30 );
  AMQP_QUEUE_PURGE_OK       : TAMQPMethodID = ( ClassID: AMQP_CLASS_QUEUE; MethodID: 31 );
  AMQP_QUEUE_DELETE         : TAMQPMethodID = ( ClassID: AMQP_CLASS_QUEUE; MethodID: 40 );
  AMQP_QUEUE_DELETE_OK      : TAMQPMethodID = ( ClassID: AMQP_CLASS_QUEUE; MethodID: 41 );

  AMQP_BASIC_QOS            : TAMQPMethodID = ( ClassID: AMQP_CLASS_BASIC; MethodID: 10 ); //TODO
  AMQP_BASIC_QOS_OK         : TAMQPMethodID = ( ClassID: AMQP_CLASS_BASIC; MethodID: 11 ); //TODO
  AMQP_BASIC_CONSUME        : TAMQPMethodID = ( ClassID: AMQP_CLASS_BASIC; MethodID: 20 );
  AMQP_BASIC_CONSUME_OK     : TAMQPMethodID = ( ClassID: AMQP_CLASS_BASIC; MethodID: 21 );
  AMQP_BASIC_CANCEL         : TAMQPMethodID = ( ClassID: AMQP_CLASS_BASIC; MethodID: 30 );
  AMQP_BASIC_CANCEL_OK      : TAMQPMethodID = ( ClassID: AMQP_CLASS_BASIC; MethodID: 31 );
  AMQP_BASIC_PUBLISH        : TAMQPMethodID = ( ClassID: AMQP_CLASS_BASIC; MethodID: 40 );
  AMQP_BASIC_RETURN         : TAMQPMethodID = ( ClassID: AMQP_CLASS_BASIC; MethodID: 50 );
  AMQP_BASIC_DELIVER        : TAMQPMethodID = ( ClassID: AMQP_CLASS_BASIC; MethodID: 60 );
  AMQP_BASIC_GET            : TAMQPMethodID = ( ClassID: AMQP_CLASS_BASIC; MethodID: 70 );
  AMQP_BASIC_GET_OK         : TAMQPMethodID = ( ClassID: AMQP_CLASS_BASIC; MethodID: 71 );
  AMQP_BASIC_GET_EMPTY      : TAMQPMethodID = ( ClassID: AMQP_CLASS_BASIC; MethodID: 72 );
  AMQP_BASIC_ACK            : TAMQPMethodID = ( ClassID: AMQP_CLASS_BASIC; MethodID: 80 );
  AMQP_BASIC_REJECT         : TAMQPMethodID = ( ClassID: AMQP_CLASS_BASIC; MethodID: 90 );
  AMQP_BASIC_RECOVER_ASYNC  : TAMQPMethodID = ( ClassID: AMQP_CLASS_BASIC; MethodID: 100 ); //TODO
  AMQP_BASIC_RECOVER        : TAMQPMethodID = ( ClassID: AMQP_CLASS_BASIC; MethodID: 110 ); //TODO
  AMQP_BASIC_RECOVER_OK     : TAMQPMethodID = ( ClassID: AMQP_CLASS_BASIC; MethodID: 111 ); //TODO

  AMQP_CONFIRM_SELECT       : TAMQPMethodID = ( ClassID: AMQP_CLASS_CONFIRM; MethodID: 10 );
  AMQP_CONFIRM_SELECT_OK    : TAMQPMethodID = ( ClassID: AMQP_CLASS_CONFIRM; MethodID: 11 );

  AMQP_TX_SELECT            : TAMQPMethodID = ( ClassID: AMQP_CLASS_TX; MethodID: 10 ); //TODO
  AMQP_TX_SELECT_OK         : TAMQPMethodID = ( ClassID: AMQP_CLASS_TX; MethodID: 11 ); //TODO
  AMQP_TX_COMMIT            : TAMQPMethodID = ( ClassID: AMQP_CLASS_TX; MethodID: 20 ); //TODO
  AMQP_TX_COMMIT_OK         : TAMQPMethodID = ( ClassID: AMQP_CLASS_TX; MethodID: 21 ); //TODO
  AMQP_TX_ROLLBACK          : TAMQPMethodID = ( ClassID: AMQP_CLASS_TX; MethodID: 30 ); //TODO
  AMQP_TX_ROLLBACK_OK       : TAMQPMethodID = ( ClassID: AMQP_CLASS_TX; MethodID: 31 ); //TODO

//  CONTENT_METHODS : array[0..3] of TAMQPMethodID = (
//      AMQP_BASIC_PUBLISH,
//      AMQP_BASIC_RETURN,
//      AMQP_BASIC_DELIVER,
//      AMQP_BASIC_GET_OK
//    );

implementation

end.
