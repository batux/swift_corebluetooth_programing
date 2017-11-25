# Swift3 CoreBluetooth Programing Basic Project

# About Core Bluetooth

The Core Bluetooth framework provides the classes needed for your iOS and Mac apps to communicate with devices that are equipped with Bluetooth low energy wireless technology. For example, your app can discover, explore, and interact with low energy peripheral devices, such as heart rate monitors and digital thermostats. As of macOS 10.9 and iOS 6, Mac and iOS devices can also function as Bluetooth low energy peripherals, serving data to other devices, including other Mac and iOS devices.

![cbtechnologyframework_2x](https://user-images.githubusercontent.com/2838457/33233754-c5571e18-d223-11e7-8a81-312d70e94937.png)

# BLE communication: The central and The peripheral

In the BLE world there are two type of devices: peripheral and central.
A peripheral is a device that exposes services and data for reading or writing.
The central is a device that connects to peripherals in order to read or write data exposed by the peripherals. The central is the device that initiates the connection to the peripheral.
In a client / server model the central can be seen as the client and the peripheral can be seen as the server.
Some devices can act a as central peripheral at the same time. iOS and Mac devices are such an example.

![cbdevices1_2x](https://user-images.githubusercontent.com/2838457/33233793-8f1492a8-d224-11e7-969f-6ed312cce20d.png)

# How the Data of a Peripheral Is Structured

The purpose of connecting to a peripheral is to begin exploring and interacting with the data it has to offer. Before you can do this, however, it helps to understand how the data of a peripheral is structured.

Peripherals may contain one or more services or provide useful information about their connected signal strength. A service is a collection of data and associated behaviors for accomplishing a function or feature of a device (or portions of that device). For example, one service of a heart rate monitor may be to expose heart rate data from the monitor’s heart rate sensor.

Services themselves are made up of either characteristics or included services (that is, references to other services). A characteristic provides further details about a peripheral’s service. For example, the heart rate service just described may contain one characteristic that describes the intended body location of the device’s heart rate sensor and another characteristic that transmits heart rate measurement data.

![cbperipheraldata_example_2x](https://user-images.githubusercontent.com/2838457/33233815-ed7437d6-d224-11e7-8d71-97bea75e4bd3.png)

Simulate a peripheral with the Mac
It is possible to simulate a BLE peripheral using a Mac with different techniques. The first that comes to mind is to make Core Bluetooth Mac app that uses the peripheral role. There is also a node.js module called bleno (https://github.com/sandeepmistry/bleno) that allows to quickly implement a BLE peripheral. We are going to use bleno in this article. 

Here is a way to get rapidly started:
1- Install Xcode
2- Install node.js
3- Open a terminal and install the bleno module: npm install bleno
4- Download the bleno github repository : https://github.com/sandeepmistry/bleno
5- Open e terminal and go to the examples/echo folder
6- Run node main.js. If you encounter errors saying “missing module”, you need to install it using npm install “module” and try again

![1-hbxcwlyihbemyylboorecq](https://user-images.githubusercontent.com/2838457/33233826-3aadbf90-d225-11e7-9d1a-a95f072229fe.png)



References

https://developer.apple.com/library/content/documentation/NetworkingInternetWeb/Conceptual/CoreBluetooth_concepts/AboutCoreBluetooth/Introduction.html#//apple_ref/doc/uid/TP40013257-CH1-SW1

https://medium.com/@yostane/getting-started-with-bluetooth-low-energy-on-ios-ada3090fc9cc
