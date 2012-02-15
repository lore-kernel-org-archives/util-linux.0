Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35994 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712Ab2BOPJt convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 15 Feb 2012 10:09:49 -0500
Received: by iacb35 with SMTP id b35so1554416iac.19
        for <util-linux@vger.kernel.org>; Wed, 15 Feb 2012 07:09:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4F3BBA72.90902@draigBrady.com>
References: <1328648733.11787.13.camel@peace.lax.corp.google.com> <4F3BBA72.90902@draigBrady.com>
From: Frank Mayhar <fmayhar@google.com>
Date: Wed, 15 Feb 2012 07:09:29 -0800
Message-ID: <CAKp+pw1irqkv7JBRWLHYWsLzCzRb6GN44C-6r3x4ZnUbUL8nuQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add functions to the fsck wrapper to improve
 standalone operation.
To: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigbrady.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

2012/2/15 Pádraig Brady <P@draigbrady.com>:
> On 02/07/2012 09:05 PM, Frank Mayhar wrote:
>> This set of patches adds functions that help improve fsck operation in
>> large installations and when running in unattended or headless mode.  It
>> adds support for reporting rusage statistics for the individual fsck
>> runs, for capturing fsck output, for killing fsck runs that take too
>> long and for running scripts when each fsck completes.
>>
>> We're currently using these functions to improve our fsck monitoring
>> capability and to replace some unwieldy and hard-to-maintain shell
>> scripts.
>
> Couldn't you do this with separate fsck command runs,
> and use standard system utils?

Yes, of course.  That's where the "unwieldy and hard-to-maintain shell
scripts" came in.  Putting the functions in the wrapper itself, on the
other hand, means the scripts don't have to reimplement functions that
already exist there (like parallelizing the fsck runs or tracking exit
status), eliminates some external dependencies and makes the process
quite a bit less fragile.
-- 
Frank Mayhar
fmayhar@google.com
