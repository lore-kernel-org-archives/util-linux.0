Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6C62C0F7F
	for <util-linux@vger.kernel.org>; Sat,  4 Apr 2026 11:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775301590; cv=none; b=qZ8J6nWqkKTBk3xhlVAomE1aXvOs5nEoUOspgZPS1++6jr7+uc2htpkwHP01Yh1yTDLzJKg4bGT3mCbpY0N6NhrUITaqazDZP7sb7gN/FU/fab9kB5uF2fTKs4ywYZ1GaV8nzoCkU3Gv1H9UMi6UGSuOjcSLxAFDvotOjlxWuN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775301590; c=relaxed/simple;
	bh=PrdvS0YV0zu/WkTT7Dmz3+Lvx0p5O/EaF8lQp41sDZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEgbPPoWvA2IPQAJZAbbVJ8KCmCZqEtWVh8qmQLOLt9Jxz2YD2Md7W57njMgl8JWXTXI3248jbFrb0iKn+7V5tt0JCflOt8/ITUUGFGC3syyTmBkXSJVX5Gm7C0PgTPrAqh0HFrMUVgtjrEz3TxPYPN7wn7lY5QMkFheNHj4CBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Z0F9jZrL; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Z0F9jZrL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ayrv+xWrc7orqmrPRLMw6rXtv0huH2To2O034XKsHBk=; b=Z0F9jZrLkK0l1AYRLFD3DGUlQV
	4O6yLHbohh9vnIX/tDGCMA4vPjJCSqf7vTm7y65XpzHhMXlvfj80kxtelvQwpgtIOHH6q3zOYK92m
	8s1ra7nQKBMKj2yLNCG0SG8s5rWVBZvi8yqSbO4xJne6XJXa9iSwrF5vljpeF3yoQl/3r9hkTNO7f
	ELQGGtiASoZ7PasFOh3ZcsTnUTwOMAi8OzCqV3/tjRCkT/XU9ZeVOWsPAgV/AF0a3RQP4YokZ2PRL
	XDpKG4izrsEoFC/Ru0hGokCviGAgrN0MATttV7kD5Z0ZTRxuum5EnpEP2Z/McCMMYjGVn7UfXG4lu
	LE1KA6yA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <zeha@debian.org>)
	id 1w8z2U-005HO2-0M;
	Sat, 04 Apr 2026 11:19:41 +0000
Date: Sat, 4 Apr 2026 13:19:39 +0200
From: Chris Hofstaedtler <zeha@debian.org>
To: Christian Albrecht Goeschel Ndjomouo <cgoesc2@wgu.edu>
Cc: Katie May <katie.may@canonical.com>, 1132588@bugs.debian.org, 
	util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>, Johannes Stezenbach <js@sig21.net>
Subject: Re: Bug#1132588: runuser: missing whitelist-environment option
Message-ID: <adDx4uLKdmKyzhCf@zeha.at>
References: <CA+499YPv1qATJg3SWqz_UrY77Lksibs5UJAaAhck0Vct3EdSuQ@mail.gmail.com>
 <ac-hE5WXBkG4pKZa@per.namespace.at>
 <SJ0P220MB0541E236A2387E8EBDB7C94BE95EA@SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <SJ0P220MB0541E236A2387E8EBDB7C94BE95EA@SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM>
X-Debian-User: zeha

Hi Christian,

* Christian Albrecht Goeschel Ndjomouo <cgoesc2@wgu.edu> [260404 01:25]:
>The issue is indeed caused by the mentioned commit ac0147f, however
>the change is necessary for proper functioning of su(1). Nevertheless, I
>have created a PR that separates the short option strings used for su(1)
>and runuser(1) as we need a different scanning mode for the former.
>
>I have also added regression tests for runuser(1) and slightly improved
>the one for su(1) so we can catch regressions earlier.

About su(1), in the meantime a Debian user filed a bug that su(1) 
regressed, too: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1132610
To quote:

| The command 'su <user> -s /bin/sh -c "echo foo"' now runs
| 'bash -s /bin/sh -c "echo foo"' instead of just
| '/bin/sh -c "echo foo"', which causes bash to hang reading commands
| from stdin.
| 
| This breaks suspend via in my setup which uses
| /usr/share/acpi-support/screenblank from the acpi-support package:
| 
|        if pidof xscreensaver >/dev/null; then
|                su "$XUSER" -s /bin/sh -c "xscreensaver-command -throttle"
|        fi

And:

| Actually the su man page says:
| 
| SYNOPSIS
|       su [options] [-] [user|UID [argument...]]
| 
| So one could argue that the acpi-support script's use of
| 'su "$XUSER" -s /bin/sh -c "..."' is buggy.
| 'su -s /bin/sh "$XUSER" -c "..."' works.
| 
| However, the acpi-support scripts (/usr/share/acpi-support/screenblank
| and /etc/acpi/lid.sh, have not checked others) worked with previous versions
| of util-linux.

It would seem that various versions of passing the command to su(1) 
are in use, and constraining them will break all these usages.

>With the patch the issue with runuser should be fixed. Can you please
>validate this ?
>
>PR: https://github.com/util-linux/util-linux/pull/4185
>
>Edit:
>
>After taking a closer look at the runuser(1) man page it seems to me that
>the actual documented syntax implies that options should always be put
>before the username and potential arguments that are to be passed to the
>shell or defined command. This aligns with the usage of su(1) and seems
>more coherent. Let's see what Karel thinks about this :D

I only had a quick look at runuser --help and the man page, and 
while it seems to imply that "-" and "-l" are supposed to do the 
same thing, I doubt this is what was intended and/or the actual
implementation.

At this point I also doubt that even if the documentation supports 
the new behaviour it's worth breaking all the existing users.

Chris

