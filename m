Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vc0-f174.google.com ([209.85.220.174]:55519 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965498Ab2LHTEy convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 8 Dec 2012 14:04:54 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so1336009vcd.19
        for <util-linux@vger.kernel.org>; Sat, 08 Dec 2012 11:04:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50C36967.8050109@zoho.com>
References: <b9e1a13168f41cde97e1fdaa21cdc5354ef535ea.1353702119.git.luto@amacapital.net>
 <5a4bb50baed87dbe00be9003dad7cc1ba59ca571.1354954632.git.luto@amacapital.net> <50C36967.8050109@zoho.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sat, 8 Dec 2012 11:04:32 -0800
Message-ID: <CALCETrXOSLW4+Xsbvfo9hN4vwaJbFanB7NpViSLxcT1-wUFDMg@mail.gmail.com>
Subject: Re: [PATCH] Add setpriv, a tool to set privileges and such
To: =?ISO-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>
Cc: util-linux@vger.kernel.org,
        =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigbrady.com>,
        Karel Zak <kzak@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Dec 8, 2012 at 8:23 AM, Ángel González <ingenit@zoho.com> wrote:
> On 08/12/12 09:19, Andy Lutomirski wrote:
>> This can set no_new_privs, uid, gid, groups, securebits, inheritable caps, the cap
>> bounding set, securebits, and selinux and apparmor labels.
>>
>> Signed-off-by: Andy Lutomirski <luto@amacapital.net>
>> ---
>
> The no_new_privs can only be set with --nnp, which is not a very
> self-documenting name.
> I would also add a long name --no-new-privs for that option.
>

Fixed, along with two silly bugs.

--Andy

>
>



-- 
Andy Lutomirski
AMA Capital Management, LLC
