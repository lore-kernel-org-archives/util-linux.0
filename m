Return-Path: util-linux-owner@vger.kernel.org
Received: from out02.mta.xmission.com ([166.70.13.232]:42247 "EHLO
	out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187Ab3EJGmC (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 10 May 2013 02:42:02 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andy Johnson <johnsonzjo@gmail.com>
Cc: util-linux@vger.kernel.org
References: <CAF0Lin2vFqLg3J_nhSkpdmzYuB56ZNn2TNqrZbSTynMB3x5Tew@mail.gmail.com>
	<87ppx057sf.fsf@xmission.com>
	<CAF0Lin2XM9kSzjDyLJS19zV-M9PdAS55hH3jwDT3ph4F7mSYLg@mail.gmail.com>
Date: Thu, 09 May 2013 23:41:56 -0700
In-Reply-To: <CAF0Lin2XM9kSzjDyLJS19zV-M9PdAS55hH3jwDT3ph4F7mSYLg@mail.gmail.com>
	(Andy Johnson's message of "Fri, 10 May 2013 09:07:51 +0300")
Message-ID: <87ip2rz68b.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: Cannot allocate memory when calling unshare
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Andy Johnson <johnsonzjo@gmail.com> writes:

> Thanks.
> Copy ans paste of that line:
> unshare --pid -- /bin/sh -c /bin/bash
>
> still gave:
> ./unshare --pid -- /bin/sh -c /bin/bash
> bash: fork: Cannot allocate memory
>
> also tried to tweak a bit and it did not help
> I am using latest git linux-util on fedora 18 with
> 3.8.4-202.fc18.x86_64 kernel

How weird.  It works here.

My hunch would be that my /bin/sh is dash, and fedora likes to use bash.
It looks like your /bin/sh is exec'ing /bin/bash instead of forking and
execing it.  You can look in another window and confirm that you don't
have two processes doing the work only one.

When it works echo $$ returns 1.

Shrug.

Eric
