package com.example.flutter_huanhu;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothManager;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.provider.Settings;

import java.util.Map;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.embedding.engine.FlutterEngine;
//import io.flutter.view.FlutterMain;

public class MainActivity extends FlutterActivity  {

    //申明方法名
    private static final String BLUETOOTH_CHANNEL="samples.flutter.io/bluetooth";

    private BluetoothManager bluetoothManager = null;	 //初始化
    private BluetoothAdapter bluetoothAdapter = null;	//蓝牙适配器

    @Override
    protected void onCreate(Bundle savedInstanceState) {
//        FlutterMain.startInitialization(this);
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(new FlutterEngine(this));

        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(),BLUETOOTH_CHANNEL).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                        final Map<String, Object> args = methodCall.arguments();
                        if(methodCall.method.equals("openBuleTooth")){	//判断flutter调用那个方法
                            if(supportBuleTooth()){						//检测真机是否支持蓝牙
                                openBuleTooth();							//打开蓝牙
                                result.success("蓝牙已经被开启");
                            }else{
                                result.error("设备不支持蓝牙",null,null);
                            }
                        }
                        else if(methodCall.method.equals("getBuleTooth")){
                            if(supportBuleTooth()){
                                if(disabled()){								//检测蓝牙的状态
                                    result.success("蓝牙已经开启");
                                }else{
                                    result.success("蓝牙未开启");
                                }
                            }
                        }else if(methodCall.method.equals("openXiTongApi")){
                            Intent it = new Intent(Settings.ACTION_BLUETOOTH_SETTINGS);
                            startActivity(it);
                            result.success("打开成功");
//                            final String type =(String) args.get("type");
//                            assert type != null;
//                            if(type.equals("Settings.ACTION_BLUETOOTH_SETTINGS")){
//                                Intent it = new Intent(Settings.ACTION_BLUETOOTH_SETTINGS);
//                                startActivity(it);
//                                result.success("打开成功");
//                            }

                        }

                    }
                }
        );
    }
    //是否支持蓝牙
    private boolean supportBuleTooth(){
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
            bluetoothManager=(BluetoothManager) getSystemService(Context.BLUETOOTH_SERVICE);
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
            bluetoothAdapter=bluetoothManager.getAdapter();
        }
        if (bluetoothAdapter==null){    //不支持蓝牙
            return false;
        }
        return true;
    }

    //打开蓝牙
    private void openBuleTooth(){
        //判断蓝牙是否开启
        Intent enabler=new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
        startActivityForResult(enabler,1);
    }

    //判断蓝牙是否已经开启
    private boolean disabled(){
        if(bluetoothAdapter.isEnabled()){
            return true;
        }
        return false;
    }


}