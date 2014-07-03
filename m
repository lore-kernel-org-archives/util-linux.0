Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:30601 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182AbaGCMgN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 3 Jul 2014 08:36:13 -0400
Message-ID: <53B54E32.4060707@redhat.com>
Date: Thu, 03 Jul 2014 14:36:02 +0200
From: Ondrej Oprala <ooprala@redhat.com>
MIME-Version: 1.0
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>,
        Janani Venkataraman <jananive@linux.vnet.ibm.com>,
        util-linux@vger.kernel.org
CC: ananth@linux.vnet.ibm.com, Tarundeep Singh <tarundsk@linux.vnet.ibm.com>
Subject: Re: Non disruptive application core dump infrastructure
References: <53871D87.2070401@linux.vnet.ibm.com> <53871E15.1040209@redhat.com> <53872BF1.5030303@in.ibm.com> <53873365.7080405@redhat.com> <53877B30.30909@in.ibm.com> <53B530B2.9090402@in.ibm.com>
In-Reply-To: <53B530B2.9090402@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 07/03/2014 12:30 PM, Suzuki K. Poulose wrote:
> On 05/29/2014 11:53 PM, Suzuki K. Poulose wrote:
>> On 05/29/2014 06:47 PM, Ondrej Oprala wrote:
>>> On 05/29/2014 02:45 PM, Suzuki K. Poulose wrote:
>>>> On 05/29/2014 05:16 PM, Ondrej Oprala wrote:
>>>>> On 05/29/2014 01:44 PM, Janani Venkataraman wrote:
>>>>>> Hi,
>>>>>>
>>>>>> We have developed a tool called "gencore" which captures the core of
>>>>>> an application without
>>>>>> disrupting its process. The dump is collected non-disruptively and
>>>>>> this tool currently supports
>>>>>> s390, x86 and power systems.
>>>>>>
>>>>>> THE TOOL:
>>>>>>
>>>>>> The tool can perform non-disruptive third party dumps. The tool also
>>>>>> contains a library "libgencore"
>>>>>> which helps applicationsto trigger self dumps.
>>>>>>
>>>>>> The tool can perform:
>>>>>>
>>>>>> 1) Third party dump: The pid of the process to dumped is given along
>>>>>> with name of the core-file to
>>>>>> be created.
>>>>>>
>>>>>> eg.
>>>>>>
>>>>>> [janani@localhost]:gencore 6616 core.test
>>>>>>
>>>>>> 2) Self dump: The programs can request a self-dump using gencore()
>>>>>> API, provided throughlibgencore. This
>>>>>> is implemented through a daemon which listens on a UNIX Filesocket for
>>>>>> such requests. The daemon is started
>>>>>> immediately post installation. The program which requires the dump
>>>>>> makes use of the gencore() API and provides
>>>>>> the name of the core-file as a parameter.
>>>>>>
>>>>>> eg.
>>>>>>
>>>>>> /* Opening the library, in this case the library is present in the
>>>>>> /usr/lib64 */
>>>>>> lib = dlopen("libgencore.so", RTLD_LAZY);
>>>>>>
>>>>>> gencore = dlsym(lib, "gencore");
>>>>>>
>>>>>> Call the API:
>>>>>> gencore("/home/janani/core_test").
>>>>>>
>>>>>> BASIC IDEA:
>>>>>>
>>>>>> The basic idea is that the threads of the process are held using
>>>>>> ptrace calls and the dump is generated in the
>>>>>> ELF format using the /proc/pid filesystem.
>>>>>>
>>>>>> PATCH SET:
>>>>>> We have designed this tool based on the discussions with linux kernel
>>>>>> community. The patches have been posted
>>>>>> at:https://lkml.org/lkml/2014/3/20/138
>>>>>>
>>>>>> Do you think this can be part of the util-linux bundle? We can tweak
>>>>>> it to make it work as a package in util-linux.
>>>>>>
>>>>>> Let us know your reviews and comments.
>>>>>>
>>>>>> Thanks.
>>>>>> Janani
>>>>>>
>>>>>> -- 
>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>> util-linux" in
>>>>>> the body of a message tomajordomo@vger.kernel.org
>>>>>> More majordomo info athttp://vger.kernel.org/majordomo-info.html
>>>>> Interesting,
>>>>> but how is this different from attaching to a process with GDB and using
>>>>> the gcore command? Or to automate it more, using the gcore script that
>>>>> comes with GDB?
>>>>> Cheers,
>>>>> Ondrej
>>>>>
>>>> There are two major issues with that.
>>>>
>>>> 1) GDB uses PTRACE_ATTACH and hence the process gets a SIGSTOP.
>>> I fail to see the downside to that.
>>>> 2) A process cannot initiate the request to dump itself, say from a
>>>> signal handler. (since fork() is not signal safe)
>>> This should be possible using libgdb. Let's say forking while in a SIGSEGV
>>> handler and using the libgdb API to do the dump.
>> Thats exactly the problem. forking within a sighandler is not safe. You
>> could possibly deadlock with glibc locks.
> Ondrej,
>
> What are your thoughts about this ?
>
> Thanks
> Suzuki
>
Hi Suzuki,

from the LKML mailing list, I can see that the biggest criticism/confusion
related to gencore comes from your necessity claims around the daemon part.

I'm not entirely sure what kind of programs is gencore going to be most 
used/useful for..
but isn't the signalfd API solving the problem of async-signal safety?
Using it, you should be able to catch the signal, safely fork
and happily exec gencore. No need for any other daemon running.

Please correct me, if I'm mistaken.

Thanks,
Ondrej

