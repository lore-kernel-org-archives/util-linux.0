Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:62845 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab3EJGHy (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 10 May 2013 02:07:54 -0400
Received: by mail-wg0-f43.google.com with SMTP id c11so3790276wgh.22
        for <util-linux@vger.kernel.org>; Thu, 09 May 2013 23:07:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87ppx057sf.fsf@xmission.com>
References: <CAF0Lin2vFqLg3J_nhSkpdmzYuB56ZNn2TNqrZbSTynMB3x5Tew@mail.gmail.com>
	<87ppx057sf.fsf@xmission.com>
Date: Fri, 10 May 2013 09:07:51 +0300
Message-ID: <CAF0Lin2XM9kSzjDyLJS19zV-M9PdAS55hH3jwDT3ph4F7mSYLg@mail.gmail.com>
Subject: Re: Cannot allocate memory when calling unshare
From: Andy Johnson <johnsonzjo@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Thanks.
Copy ans paste of that line:
unshare --pid -- /bin/sh -c /bin/bash

still gave:
./unshare --pid -- /bin/sh -c /bin/bash
bash: fork: Cannot allocate memory

also tried to tweak a bit and it did not help
I am using latest git linux-util on fedora 18 with 3.8.4-202.fc18.x86_64 kernel

regards,
Andy


On Thu, May 9, 2013 at 9:26 PM, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Andy Johnson <johnsonzjo@gmail.com> writes:
>
>> Hello,
>> I use git last update of util-linux.
>>
>> ./unshare -n /bin/bash
>> works ok.
>>
>> From a different terminal I run:
>>
>> ./unshare -p /bin/bash
>> and get:
>> bash: fork: Cannot allocate memory
>>
>> typing:
>> shows 141 Mb free.
>>
>> the machine has x86_64 ubuntu, 13.04, Raring Ringtail
>>
>> any advice ?
>
> Pid namespaces are funny.  What you are seeing is expected and correct
> behavior.  The process that calls unshare is not put into the pid
> namespace it's first child is.  Which means that the first child of bash
> becomes the init in the pid namespace and the next child of bash.
>
> The following should do what you want.
> unshare --pid -- /bin/sh -c /bin/bash
>
> Eric
