#include <Arduino_FreeRTOS.h>
void TaskBlink1( void *pvParameters );
void TaskBlink2( void *pvParameters );
void Taskprint( void *pvParameters );
void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
  xTaskCreate(
    TaskBlink1
    ,  "task1"   
    ,  128  
    ,  NULL
    ,  1  
    ,  NULL );
  xTaskCreate(
    TaskBlink2
    ,  "task2"
    ,  128  
    ,  NULL
    ,  2  
    ,  NULL );
    xTaskCreate(
    Taskprint
    ,  "task3"
    ,  128  
    ,  NULL
    ,  2  
    ,  NULL );
vTaskStartScheduler();
}
void loop()
{
}
void TaskBlink1(void *pvParameters)  {
  pinMode(6, OUTPUT);
  
    Serial.println("Task1");
    digitalWrite(6, HIGH);   
    vTaskDelay( 200 / portTICK_PERIOD_MS ); 
    digitalWrite(6, LOW);    
    vTaskDelay( 200 / portTICK_PERIOD_MS ); 
  
}
void TaskBlink2(void *pvParameters)  
{
  pinMode(7, OUTPUT);
  
    Serial.println("Task2");
    digitalWrite(7, HIGH);   
    vTaskDelay( 300 / portTICK_PERIOD_MS ); 
    digitalWrite(7, LOW);   
    vTaskDelay( 300 / portTICK_PERIOD_MS ); 
  
}
void Taskprint(void *pvParameters)  
{
    pinMode(5, OUTPUT);

  
    Serial.println("Task2");
    digitalWrite(5, HIGH);   
    vTaskDelay( 300 / portTICK_PERIOD_MS ); 
    digitalWrite(5, LOW);   
    vTaskDelay( 300 / portTICK_PERIOD_MS );

}
