Return-Path: util-linux-owner@vger.kernel.org
Received: from mail3.vodafone.ie ([213.233.128.45]:12496 "EHLO
	mail3.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757931Ab2BOOKN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 15 Feb 2012 09:10:13 -0500
Message-ID: <4F3BBA72.90902@draigBrady.com>
Date: Wed, 15 Feb 2012 14:00:18 +0000
From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
MIME-Version: 1.0
To: Frank Mayhar <fmayhar@google.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/4] Add functions to the fsck wrapper to improve standalone
 operation.
References: <1328648733.11787.13.camel@peace.lax.corp.google.com>
In-Reply-To: <1328648733.11787.13.camel@peace.lax.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 02/07/2012 09:05 PM, Frank Mayhar wrote:
> This set of patches adds functions that help improve fsck operation in
> large installations and when running in unattended or headless mode.  It
> adds support for reporting rusage statistics for the individual fsck
> runs, for capturing fsck output, for killing fsck runs that take too
> long and for running scripts when each fsck completes.
> 
> We're currently using these functions to improve our fsck monitoring
> capability and to replace some unwieldy and hard-to-maintain shell
> scripts.

Couldn't you do this with separate fsck command runs,
and use standard system utils?

flist="/dev/sda1 /dev/sda2"
for sys in $flist; do
  timeout 10m fsck > /var/log/fsck.$(basename $sys) \
    && success_script $sys \
    || fail_script $sys
done

cheers,
Pádraig.
