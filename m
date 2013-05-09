Return-Path: util-linux-owner@vger.kernel.org
Received: from out03.mta.xmission.com ([166.70.13.233]:57978 "EHLO
	out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab3EIS03 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 9 May 2013 14:26:29 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andy Johnson <johnsonzjo@gmail.com>
Cc: util-linux@vger.kernel.org
References: <CAF0Lin2vFqLg3J_nhSkpdmzYuB56ZNn2TNqrZbSTynMB3x5Tew@mail.gmail.com>
Date: Thu, 09 May 2013 11:26:24 -0700
In-Reply-To: <CAF0Lin2vFqLg3J_nhSkpdmzYuB56ZNn2TNqrZbSTynMB3x5Tew@mail.gmail.com>
	(Andy Johnson's message of "Tue, 7 May 2013 08:03:29 +0300")
Message-ID: <87ppx057sf.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: Cannot allocate memory when calling unshare
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Andy Johnson <johnsonzjo@gmail.com> writes:

> Hello,
> I use git last update of util-linux.
>
> ./unshare -n /bin/bash
> works ok.
>
> From a different terminal I run:
>
> ./unshare -p /bin/bash
> and get:
> bash: fork: Cannot allocate memory
>
> typing:
> shows 141 Mb free.
>
> the machine has x86_64 ubuntu, 13.04, Raring Ringtail
>
> any advice ?

Pid namespaces are funny.  What you are seeing is expected and correct
behavior.  The process that calls unshare is not put into the pid
namespace it's first child is.  Which means that the first child of bash
becomes the init in the pid namespace and the next child of bash.

The following should do what you want.
unshare --pid -- /bin/sh -c /bin/bash

Eric
