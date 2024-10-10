<h2 align="center">
Logstash Command and Usage Documentation
</h2>

#### Java Version:

check java

```bash 
java -version
```

Install Java:

```bash 
sudo yum install java
```

#### Install Logstash:

Add the Logstash repository:

```bash sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
sudo sh -c 'echo "[logstash-7.x]
name=Elastic repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md" > /etc/yum.repos.d/logstash.repo' 
```

#### Install Logstash:

```bash
sudo yum install logstash
```


Configure Logstash for Kafka:
Create a Logstash configuration file for Kafka. For example, you can create a file named kafka.conf:


```bash
sudo vim /etc/logstash/conf.d/kafka-elastic-pipeline.conf
```

#### Add the following configuration:

```bash
conf
Copy code
input {
  kafka {
    bootstrap_servers => "your_kafka_bootstrap_servers"
    topics => ["your_kafka_topic"]
    group_id => "your_group_id"
  }
}

output {
  stdout {
    codec => rubydebug
  }

  # You can add other output plugins as needed
}
```
Replace placeholders like your_kafka_bootstrap_servers, your_kafka_topic, and your_group_id with your Kafka bootstrap servers, topic, and group ID.

#### Start Logstash:

```bash
sudo service logstash start
```
#### You can check the Logstash logs for any errors:


```bash
sudo tail -f /var/log/logstash/logstash-plain.log
```

Ensure Logstash is running without errors.

This is a basic setup. Depending on your use case, you may need to enhance the Logstash configuration and add more filters or outputs.

Remember to consult the official Logstash documentation for more advanced configurations and troubleshooting.


#### Check Logstash Service Status:

You can check whether the Logstash service is running using the following command:


```bash
sudo service logstash status
```
If Logstash is installed and running, you should see a message indicating that the Logstash service is active.

#### Check Logstash Version:

You can check the installed Logstash version using the following command:


```bash
logstash --version
```
This will print the Logstash version information to the console.

Check Logstash Installation Directory:

The default installation directory for Logstash on CentOS is /usr/share/logstash. You can check if Logstash files are present in this directory:

```bash
ls /usr/share/logstash
```
If Logstash is installed, you should see various Logstash-related directories and files.

#### Check Logstash Configuration Directory:

Logstash configuration files are typically stored in /etc/logstash/conf.d/. You can check if this directory exists:

```bash
ls /etc/logstash/conf.d/
```
If Logstash is installed, this directory should contain your Logstash configuration files.

By using these commands, you can determine whether Logstash is installed and running on your CentOS system. If Logstash is not installed, you may need to follow the installation steps mentioned in the previous response.


#### View Logstash Logs:

You can view the Logstash logs directly using the cat or less command. The main Logstash log file is typically located at /var/log/logstash/logstash-plain.log. Use the following command to view the contents of the log file:


```bash
sudo cat /var/log/logstash/logstash-plain.log
```
Alternatively, you can use less for a more interactive experience:


```bash
sudo less /var/log/logstash/logstash-plain.log
```
To exit less, press q.

#### Tail Logstash Logs:

If you want to continuously monitor new log entries as they are added, you can use the tail command. For example, to tail the Logstash log file in real-time:

```bash
sudo tail -f /var/log/logstash/logstash-plain.log
```
This command will display new log entries as they are written to the log file. To stop monitoring, press Ctrl+C.

#### Check Logstash Configtest Output:

Before starting Logstash, it's a good practice to perform a configuration test. You can do this using the following command:

```bash
sudo /usr/share/logstash/bin/logstash --configtest --path.settings /etc/logstash
```
This command checks the Logstash configuration files for syntax errors and prints the result to the console.

These commands will help you access and monitor the Logstash logs, allowing you to troubleshoot issues or monitor the system's behavior. If you encounter any errors or issues, examining the logs is often the first step in diagnosing and resolving problems.


```bash
sudo service logstash stop
```
Redirecting to /bin/systemctl stop logstash.service


The message "Redirecting to /bin/systemctl stop logstash.service" indicates that the service command is redirecting the request to systemctl, which is the default service management command on systems using systemd.

If you've used the sudo service logstash stop command, and it's redirecting to systemctl, it means that your system is using systemd for managing services. In systemd-based systems, you can use the following systemctl command directly:


```bash
sudo systemctl stop logstash
```
This command will stop the Logstash service. If you want to start or restart the service, you can use start or restart instead of stop in the command.


#### Start Logstash
```bash
sudo systemctl start logstash
```

#### Restart Logstash
```bash
sudo systemctl restart logstash
```
Remember to replace start, stop, or restart with the action you want to perform.


If you need to forcefully stop a process, you can use the kill command to send a signal to the process. Here's how you can forcefully stop the Logstash process:

Find the Logstash process ID (PID):

#### You can use the pgrep or ps command to find the PID of the Logstash process. For example:


```bash
pgrep -f logstash
```
This command will display the PID of the Logstash process.

Use the kill command to stop the process forcefully:

Once you have the PID, you can use the kill command to send a signal to the Logstash process. The default signal is SIGTERM, but if the process doesn't respond to that, you can use SIGKILL to forcefully terminate it.


#### Use SIGTERM (default)
```bash
sudo kill PID_of_Logstash
```

#### Use SIGKILL if necessary
```
sudo kill -9 PID_of_Logstash
```
Replace PID_of_Logstash with the actual PID you obtained in step 1.

Please note that forcefully stopping a process using SIGKILL doesn't give the process a chance to clean up or release resources, so it should be used as a last resort. If possible, it's better to try stopping a process gracefully first using SIGTERM. Only use SIGKILL if the process doesn't respond to the regular termination signal.

Error:

[2024-01-22T20:57:13,827][INFO ][logstash.runner          ] Log4j configuration path used is: /etc/logstash/log4j2.properties
[2024-01-22T20:57:13,835][INFO ][logstash.runner          ] Starting Logstash {"logstash.version"=>"7.17.16", "jruby.version"=>"jruby 9.2.20.1 (2.5.8) 2021-11-30 2a2962fbd1 OpenJDK 64-Bit Server VM 11.0.20+8 on 11.0.20+8 +indy +jit [linux-x86_64]"}
[2024-01-22T20:57:13,836][INFO ][logstash.runner          ] JVM bootstrap flags: [-Xms1g, -Xmx1g, -XX:+UseConcMarkSweepGC, -XX:CMSInitiatingOccupancyFraction=75, -XX:+UseCMSInitiatingOccupancyOnly, -Djava.awt.headless=true, -Dfile.encoding=UTF-8, -Djdk.io.File.enableADS=true, -Djruby.compile.invokedynamic=true, -Djruby.jit.threshold=0, -Djruby.regexp.interruptible=true, -XX:+HeapDumpOnOutOfMemoryError, -Djava.security.egd=file:/dev/urandom, -Dlog4j2.isThreadContextMapInheritable=true]
[2024-01-22T20:57:15,131][INFO ][logstash.agent           ] Successfully started Logstash API endpoint {:port=>9600, :ssl_enabled=>false}
[2024-01-22T20:57:15,854][ERROR][logstash.agent           ] Failed to execute action {:action=>LogStash::PipelineAction::Create/pipeline_id:main, :exception=>"LogStash::ConfigurationError", :message=>"Expected one of [ \\t\\r\\n], \"#\", \"{\", \",\", \"]\" at line 9, column 17 (byte 181) after input {\n  kafka {\n    topics => [\"SumittedEnqReqTest\"]\n    bootstrap_servers => \"172.8.9.41:9092\"\n    codec => json\n    tags => [\"SumittedEnqReqTest]\n  }\n  kafka {\n    topics => [\"", :backtrace=>["/usr/share/logstash/logstash-core/lib/logstash/compiler.rb:32:in `compile_imperative'", "org/logstash/execution/AbstractPipelineExt.java:189:in `initialize'", "org/logstash/execution/JavaBasePipelineExt.java:72:in `initialize'", "/usr/share/logstash/logstash-core/lib/logstash/java_pipeline.rb:48:in `initialize'", "/usr/share/logstash/logstash-core/lib/logstash/pipeline_action/create.rb:52:in `execute'", "/usr/share/logstash/logstash-core/lib/logstash/agent.rb:392:in `block in converge_state'"]}
[2024-01-22T20:57:15,921][INFO ][logstash.runner          ] Logstash shut down.
[2024-01-22T20:57:15,927][FATAL][org.logstash.Logstash    ] Logstash stopped processing because of an error: (SystemExit) exit
org.jruby.exceptions.SystemExit: (SystemExit) exit
        at org.jruby.RubyKernel.exit(org/jruby/RubyKernel.java:747) ~[jruby-complete-9.2.20.1.jar:?]
        at org.jruby.RubyKernel.exit(org/jruby/RubyKernel.java:710) ~[jruby-complete-9.2.20.1.jar:?]
        at usr.share.logstash.lib.bootstrap.environment.<main>(/usr/share/logstash/lib/bootstrap/environment.rb:94) ~[?:?]
ChatGPT
The Logstash startup error you're encountering indicates a configuration error in your Logstash pipeline configuration file. The specific error message is:


plaintext
````bash
LogStash::ConfigurationError", :message=>"Expected one of [ \t\r\n], \"#\", \"{\", \",\", \"]\" at line 9, column 17 (byte 181) after input {
  kafka {
    topics => ["SumittedEnqReqTest"]
    bootstrap_servers => "172.8.9.41:9092"
    codec => json
    tags => ["SumittedEnqReqTest]
  }
  kafka {
    topics => ["
````
The error points to a syntax issue on line 9 of your Logstash configuration file. It seems that there's a typo in the tags array where the double quote is not closed properly. The corrected part of the configuration should look like this:


  ```bash
  tags => ["SumittedEnqReqTest"]
  ```
Note the corrected closing double quote.

Here's the corrected version of your Logstash configuration:

```conf
input {
  kafka {
    topics => ["SumittedEnqReqTest"]
    bootstrap_servers => "172.8.9.41:9092"
    codec => json
    tags => ["SumittedEnqReqTest"]
  }
  kafka {
    topics => ["YourOtherTopic"]
    bootstrap_servers => "YourOtherBootstrapServers"
    codec => json
    tags => ["YourOtherTags"]
  }
}
```


### Install Logtash with docker

followin is docker compose file
```yaml
version: '3'
services:
  logstash:
    image: docker.elastic.co/logstash/logstash:8.9.0
    container_name: logstash
    volumes:
      - ./logstash/pipeline:/usr/share/logstash/pipeline
    ports:
      - "5044:5044"
```

If want to expose logstash port then add following with logstash.conf file with input section
```conf
beats {
    port => 5044
    tags => ["filebeat-logs"]
  }
```



