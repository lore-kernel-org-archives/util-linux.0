Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45398 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750714AbaGDL4N (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 4 Jul 2014 07:56:13 -0400
Message-ID: <53B69653.4020905@redhat.com>
Date: Fri, 04 Jul 2014 13:56:03 +0200
From: Ondrej Oprala <ooprala@redhat.com>
MIME-Version: 1.0
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>,
        Janani Venkataraman <jananive@linux.vnet.ibm.com>,
        util-linux@vger.kernel.org
CC: ananth@linux.vnet.ibm.com, Tarundeep Singh <tarundsk@linux.vnet.ibm.com>
Subject: Re: Non disruptive application core dump infrastructure
References: <53871D87.2070401@linux.vnet.ibm.com> <53871E15.1040209@redhat.com> <53872BF1.5030303@in.ibm.com> <53873365.7080405@redhat.com> <53877B30.30909@in.ibm.com> <53B530B2.9090402@in.ibm.com> <53B54E32.4060707@redhat.com> <53B5537A.3080503@in.ibm.com>
In-Reply-To: <53B5537A.3080503@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 07/03/2014 02:58 PM, Suzuki K. Poulose wrote:
> On 07/03/2014 06:06 PM, Ondrej Oprala wrote:
>> On 07/03/2014 12:30 PM, Suzuki K. Poulose wrote:
>>> On 05/29/2014 11:53 PM, Suzuki K. Poulose wrote:
>>>> On 05/29/2014 06:47 PM, Ondrej Oprala wrote:
>>>>> On 05/29/2014 02:45 PM, Suzuki K. Poulose wrote:
>>>>>> On 05/29/2014 05:16 PM, Ondrej Oprala wrote:
>>>>>>> On 05/29/2014 01:44 PM, Janani Venkataraman wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> We have developed a tool called "gencore" which captures the core of
>>>>>>>> an application without
>>>>>>>> disrupting its process. The dump is collected non-disruptively and
>>>>>>>> this tool currently supports
>>>>>>>> s390, x86 and power systems.
>>>>>>>>
>>>>>>>> THE TOOL:
>>>>>>>>
>>>>>>>> The tool can perform non-disruptive third party dumps. The tool also
>>>>>>>> contains a library "libgencore"
>>>>>>>> which helps applicationsto trigger self dumps.
>>>>>>>>
>>>>>>>> The tool can perform:
>>>>>>>>
>>>>>>>> 1) Third party dump: The pid of the process to dumped is given along
>>>>>>>> with name of the core-file to
>>>>>>>> be created.
>>>>>>>>
>>>>>>>> eg.
>>>>>>>>
>>>>>>>> [janani@localhost]:gencore 6616 core.test
>>>>>>>>
>>>>>>>> 2) Self dump: The programs can request a self-dump using gencore()
>>>>>>>> API, provided throughlibgencore. This
>>>>>>>> is implemented through a daemon which listens on a UNIX
>>>>>>>> Filesocket for
>>>>>>>> such requests. The daemon is started
>>>>>>>> immediately post installation. The program which requires the dump
>>>>>>>> makes use of the gencore() API and provides
>>>>>>>> the name of the core-file as a parameter.
>>>>>>>>
>>>>>>>> eg.
>>>>>>>>
>>>>>>>> /* Opening the library, in this case the library is present in the
>>>>>>>> /usr/lib64 */
>>>>>>>> lib = dlopen("libgencore.so", RTLD_LAZY);
>>>>>>>>
>>>>>>>> gencore = dlsym(lib, "gencore");
>>>>>>>>
>>>>>>>> Call the API:
>>>>>>>> gencore("/home/janani/core_test").
>>>>>>>>
>>>>>>>> BASIC IDEA:
>>>>>>>>
>>>>>>>> The basic idea is that the threads of the process are held using
>>>>>>>> ptrace calls and the dump is generated in the
>>>>>>>> ELF format using the /proc/pid filesystem.
>>>>>>>>
>>>>>>>> PATCH SET:
>>>>>>>> We have designed this tool based on the discussions with linux
>>>>>>>> kernel
>>>>>>>> community. The patches have been posted
>>>>>>>> at:https://lkml.org/lkml/2014/3/20/138
>>>>>>>>
>>>>>>>> Do you think this can be part of the util-linux bundle? We can tweak
>>>>>>>> it to make it work as a package in util-linux.
>>>>>>>>
>>>>>>>> Let us know your reviews and comments.
>>>>>>>>
>>>>>>>> Thanks.
>>>>>>>> Janani
>>>>>>>>
>>>>>>>> -- 
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>>> util-linux" in
>>>>>>>> the body of a messagetomajordomo@vger.kernel.org
>>>>>>>> More majordomo info athttp://vger.kernel.org/majordomo-info.html
>>>>>>> Interesting,
>>>>>>> but how is this different from attaching to a process with GDB and
>>>>>>> using
>>>>>>> the gcore command? Or to automate it more, using the gcore script
>>>>>>> that
>>>>>>> comes with GDB?
>>>>>>> Cheers,
>>>>>>> Ondrej
>>>>>>>
>>>>>> There are two major issues with that.
>>>>>>
>>>>>> 1) GDB uses PTRACE_ATTACH and hence the process gets a SIGSTOP.
>>>>> I fail to see the downside to that.
>>>>>> 2) A process cannot initiate the request to dump itself, say from a
>>>>>> signal handler. (since fork() is not signal safe)
>>>>> This should be possible using libgdb. Let's say forking while in a
>>>>> SIGSEGV
>>>>> handler and using the libgdb API to do the dump.
>>>> Thats exactly the problem. forking within a sighandler is not safe. You
>>>> could possibly deadlock with glibc locks.
>>> Ondrej,
>>>
>>> What are your thoughts about this ?
>>>
>>> Thanks
>>> Suzuki
>>>
>> Hi Suzuki,
>>
>> from the LKML mailing list, I can see that the biggest criticism/confusion
>> related to gencore comes from your necessity claims around the daemon part.
> The daemon part was a shared philosophy from the CRIU project. There is
> no other reliable way of doing a self dump.
Yes, I think that you explained the problem with self-ptrace
clearly enough on the LKML.
>> I'm not entirely sure what kind of programs is gencore going to be most
>> used/useful for..
> This can be used by huge applications, like, JAVA RUNTIME, to trigger a
> dump when it detects some issues, without actually bringing down the
> workload.
Well, on 64-bit archs, huge programs may eat up terabytes of
virtual memory, so normal dumps are sometimes close to impossible
(though I'd really like to stress-test gdb with a massive 1TB coredump).
Do you somehow get the process' VM size before dumping?
To limit the mappings to be dumped, for example...
>> but isn't the signalfd API solving the problem of async-signal safety?
>> Using it, you should be able to catch the signal, safely fork
>> and happily exec gencore.
> This imposes a lot of changes in the applications that may want to use
> the API and is prone to errors in attaining the same.
But see, now we've moved from "CAN'T be done in any other way"
to "CAN be done in other ways, although it might be non-trivial
for some projects". I'm not saying the daemon doesn't have its
usecases. I'm only trying to point out here, that there indeed ARE
other ways.
>> No need for any other daemon running.
>>
> The daemon doesn't add much overhead. With systemd, you could make use
> of the socket option to optimize the triggering of the gencore.
I still haven't had time to look at the code itself. Does the daemon
have to be running if I want to use the signalfd + fork + exec(gencore) 
approach
mentioned above?
> Btw, here is the link to the discussion about fork async-signal safety.
> https://sourceware.org/bugzilla/show_bug.cgi?id=4737#c12
Yep, I've read that.
>> Please correct me, if I'm mistaken.
>>
>> Thanks,
>> Ondrej
>>
Cheers,
Ondrej
