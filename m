Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:35439 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751145Ab2DBLxZ convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Apr 2012 07:53:25 -0400
Received: by lahj13 with SMTP id j13so2852611lah.19
        for <util-linux@vger.kernel.org>; Mon, 02 Apr 2012 04:53:23 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20120402111029.GA1084@x2.net.home>
References: <20120330150457.GE23437@x2.net.home>
	<1333304372-25944-1-git-send-email-kerolasa@iki.fi>
	<1333304372-25944-4-git-send-email-kerolasa@iki.fi>
	<20120402111029.GA1084@x2.net.home>
Date: Mon, 2 Apr 2012 13:53:23 +0200
Message-ID: <CAG27Bk2oU12RWj=HWqE7hbx0c1f_ib=d6NCn8uQ1H1C3HGoLuA@mail.gmail.com>
Subject: Re: [PATCH 3/3] chkdupexe: reimplement command in C
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org,
        =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigbrady.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Apr 2, 2012 at 13:10, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Apr 01, 2012 at 08:19:32PM +0200, Sami Kerola wrote:
>> The new version of the command is nearly identical to old.  Major
>> differences are:
>>
>> * New output is a little rough what comes to alignment.  This is
>>   flagged as FIXME item in source.
>> * The command is much quicker than perl implementation which used
>>   to exec ls -ldU.
>> * Size of chkdupexe binary is about five times bigger than perl
>>   script.
>
> I have doubts about chkdupexe, do we really need this command?
>
>  * it provides very rarely used functionality (for example nobody
>   complains that the command is missing in Fedora/RHEL ;-)
>
>  * it seems that you can replace it by
>
>    ls $(echo "$PATH" | tr : ' ') | sort | uniq -d
>
>   or we can extend which(1) or so...
>
>
>  I see two possible ways:
>
>  1) mark chkdupexe as deprecated and remove it from distros
>
>  2) or add new command (lspath ?) and get much more information from
>  $PATH (like duplicates, per-directory stats, per-owner stats,
>  per-device stats, selinux summary, suids, etc.) and make chkdupexe as
>  alias to the new command (just for backward compatibility).
>
>  If 2) makes sense then it would be better to have it in coreutils ;-)
>
>
>  CC: Padraig
>
>  ... let's flame :-)

I am in favour of removal. As you said few, if anyone, is using this
command and to be honest I do not know why I would use it. Duplicated
commands in path are more likely to be intentional than interesting.
Perhaps extended 'lspath' might be more useful, but again I'm
struggling to come up with real use case, and the fact that existing
tools allow quite easily do similar things. For example find suid bit
executables.

find $(echo $PATH | tr ':' ' ') -mindepth 1 -maxdepth 1  -perm -u+s

Besides isn't the path polluted enough with all sort of legacy things?
Shouldn't removing of crud be considered virtue?

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
