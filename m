Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39279 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756971AbaE2Lrt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 May 2014 07:47:49 -0400
Message-ID: <53871E15.1040209@redhat.com>
Date: Thu, 29 May 2014 13:46:29 +0200
From: Ondrej Oprala <ooprala@redhat.com>
MIME-Version: 1.0
To: Janani Venkataraman <jananive@linux.vnet.ibm.com>,
        util-linux@vger.kernel.org
CC: "Suzuki K. Poulose" <suzuki@in.ibm.com>, ananth@linux.vnet.ibm.com,
        Tarundeep Singh <tarundsk@linux.vnet.ibm.com>
Subject: Re: Non disruptive application core dump infrastructure
References: <53871D87.2070401@linux.vnet.ibm.com>
In-Reply-To: <53871D87.2070401@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 05/29/2014 01:44 PM, Janani Venkataraman wrote:
> Hi,
>
> We have developed a tool called "gencore" which captures the core of 
> an application without
> disrupting its process. The dump is collected non-disruptively and 
> this tool currently supports
> s390, x86 and power systems.
>
> THE TOOL:
>
> The tool can perform non-disruptive third party dumps. The tool also 
> contains a library "libgencore"
> which helps applicationsto trigger self dumps.
>
> The tool can perform:
>
> 1) Third party dump: The pid of the process to dumped is given along 
> with name of the core-file to
> be created.
>
> eg.
>
> [janani@localhost]:gencore 6616 core.test
>
> 2) Self dump: The programs can request a self-dump using gencore() 
> API, provided throughlibgencore. This
> is implemented through a daemon which listens on a UNIX Filesocket for 
> such requests. The daemon is started
> immediately post installation. The program which requires the dump 
> makes use of the gencore() API and provides
> the name of the core-file as a parameter.
>
> eg.
>
> /* Opening the library, in this case the library is present in the 
> /usr/lib64 */
> lib = dlopen("libgencore.so", RTLD_LAZY);
>
> gencore = dlsym(lib, "gencore");
>
> Call the API:
> gencore("/home/janani/core_test").
>
> BASIC IDEA:
>
> The basic idea is that the threads of the process are held using 
> ptrace calls and the dump is generated in the
> ELF format using the /proc/pid filesystem.
>
> PATCH SET:
> We have designed this tool based on the discussions with linux kernel 
> community. The patches have been posted
> at: https://lkml.org/lkml/2014/3/20/138
>
> Do you think this can be part of the util-linux bundle? We can tweak 
> it to make it work as a package in util-linux.
>
> Let us know your reviews and comments.
>
> Thanks.
> Janani
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Interesting,
but how is this different from attaching to a process with GDB and using 
the gcore command? Or to automate it more, using the gcore script that 
comes with GDB?
Cheers,
Ondrej
