Return-Path: util-linux-owner@vger.kernel.org
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:36072 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755814AbaE2SYH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 29 May 2014 14:24:07 -0400
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <suzuki@in.ibm.com>;
	Thu, 29 May 2014 23:54:04 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 48B923940048
	for <util-linux@vger.kernel.org>; Thu, 29 May 2014 23:54:02 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s4TIODAq8126838
	for <util-linux@vger.kernel.org>; Thu, 29 May 2014 23:54:14 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s4TINuPa027657
	for <util-linux@vger.kernel.org>; Thu, 29 May 2014 23:54:00 +0530
Message-ID: <53877B30.30909@in.ibm.com>
Date: Thu, 29 May 2014 23:53:44 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Ondrej Oprala <ooprala@redhat.com>,
        Janani Venkataraman <jananive@linux.vnet.ibm.com>,
        util-linux@vger.kernel.org
CC: ananth@linux.vnet.ibm.com, Tarundeep Singh <tarundsk@linux.vnet.ibm.com>
Subject: Re: Non disruptive application core dump infrastructure
References: <53871D87.2070401@linux.vnet.ibm.com> <53871E15.1040209@redhat.com> <53872BF1.5030303@in.ibm.com> <53873365.7080405@redhat.com>
In-Reply-To: <53873365.7080405@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 05/29/2014 06:47 PM, Ondrej Oprala wrote:
> On 05/29/2014 02:45 PM, Suzuki K. Poulose wrote:
>> On 05/29/2014 05:16 PM, Ondrej Oprala wrote:
>>> On 05/29/2014 01:44 PM, Janani Venkataraman wrote:
>>>> Hi,
>>>>
>>>> We have developed a tool called "gencore" which captures the core of
>>>> an application without
>>>> disrupting its process. The dump is collected non-disruptively and
>>>> this tool currently supports
>>>> s390, x86 and power systems.
>>>>
>>>> THE TOOL:
>>>>
>>>> The tool can perform non-disruptive third party dumps. The tool also
>>>> contains a library "libgencore"
>>>> which helps applicationsto trigger self dumps.
>>>>
>>>> The tool can perform:
>>>>
>>>> 1) Third party dump: The pid of the process to dumped is given along
>>>> with name of the core-file to
>>>> be created.
>>>>
>>>> eg.
>>>>
>>>> [janani@localhost]:gencore 6616 core.test
>>>>
>>>> 2) Self dump: The programs can request a self-dump using gencore()
>>>> API, provided throughlibgencore. This
>>>> is implemented through a daemon which listens on a UNIX Filesocket for
>>>> such requests. The daemon is started
>>>> immediately post installation. The program which requires the dump
>>>> makes use of the gencore() API and provides
>>>> the name of the core-file as a parameter.
>>>>
>>>> eg.
>>>>
>>>> /* Opening the library, in this case the library is present in the
>>>> /usr/lib64 */
>>>> lib = dlopen("libgencore.so", RTLD_LAZY);
>>>>
>>>> gencore = dlsym(lib, "gencore");
>>>>
>>>> Call the API:
>>>> gencore("/home/janani/core_test").
>>>>
>>>> BASIC IDEA:
>>>>
>>>> The basic idea is that the threads of the process are held using
>>>> ptrace calls and the dump is generated in the
>>>> ELF format using the /proc/pid filesystem.
>>>>
>>>> PATCH SET:
>>>> We have designed this tool based on the discussions with linux kernel
>>>> community. The patches have been posted
>>>> at: https://lkml.org/lkml/2014/3/20/138
>>>>
>>>> Do you think this can be part of the util-linux bundle? We can tweak
>>>> it to make it work as a package in util-linux.
>>>>
>>>> Let us know your reviews and comments.
>>>>
>>>> Thanks.
>>>> Janani
>>>>
>>>> -- 
>>>> To unsubscribe from this list: send the line "unsubscribe
>>>> util-linux" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Interesting,
>>> but how is this different from attaching to a process with GDB and using
>>> the gcore command? Or to automate it more, using the gcore script that
>>> comes with GDB?
>>> Cheers,
>>> Ondrej
>>>
>> There are two major issues with that.
>>
>> 1) GDB uses PTRACE_ATTACH and hence the process gets a SIGSTOP.
> I fail to see the downside to that.
>> 2) A process cannot initiate the request to dump itself, say from a
>> signal handler. (since fork() is not signal safe)
> This should be possible using libgdb. Let's say forking while in a SIGSEGV
> handler and using the libgdb API to do the dump.
Thats exactly the problem. forking within a sighandler is not safe. You
could possibly deadlock with glibc locks.

Thanks
Suzuki

>> Thanks
>> Suzuki
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe util-linux" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Thanks,
> Ondrej
> 

