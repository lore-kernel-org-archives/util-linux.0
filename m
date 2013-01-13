Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ie0-f175.google.com ([209.85.223.175]:62440 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755765Ab3AMTbU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Jan 2013 14:31:20 -0500
Received: by mail-ie0-f175.google.com with SMTP id qd14so4148815ieb.6
        for <util-linux@vger.kernel.org>; Sun, 13 Jan 2013 11:31:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50F2FBBE.7000305@gmail.com>
References: <1358068345-773-1-git-send-email-cmaloney@theoreticalchaos.com> <50F2FBBE.7000305@gmail.com>
From: Cody Maloney <cmaloney@theoreticalchaos.com>
Date: Sun, 13 Jan 2013 12:31:00 -0700
Message-ID: <CA+K3q6qJfS_SzFFU2pJd5jRx-ooaKgZZv9F3ubtQU2hwd98i9Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Add support for using libuser to chsh and chfn
To: Bruce Dubbs <bruce.dubbs@gmail.com>, util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>
> I'm not sure if I understand the changes completely, but it does not appear
> that the changes adding PAM to chfn and chsh are optional.  By default, we
> do not use PAM and need a way build these programs without it.
>

If you look at the patch where I extract the pam function (2/4), I
don't change the code flow in the case where pam is not used
(REQUIRE_PASSWORD isn't defined). By default, REQUIRE_PASSWORD is
defined (and can be disabled with the configure flag
--disable-required-password).

Whether or not the pam headers are included has not changed. (They
were included previously even when REQUIRE_PASSWORD wasn't defined),
see patch 2/4. This means if you tried to build either of these
without the PAM headers on your system previously, it wouldn't of
worked. This may be a bug in and of itself which would be relatively
simple to fix now (don't compile/link auth.c, ifdef out the auth_pam
call, and remove the ifdefs from auth_pam.c).

In the case that the programs are run by root and REQUIRE_PASSWORD is
defined, the PAM authentication has an auth bypass for when run by
root (but not just setuid).

The libuser code is entirely optional, and does not mandate PAM in and of
itself. if you turn off REQUIRE_PASSWORD, libuser won't require a
password from the user as it's password from the user goes through the
same auth_pam function to get the password. Without REQUIRE_PASSWORD,
we basically just do any auth that libuser requires internally (A
password to an LDAP server, potentially, for instance), then don't
further authenticate the user via PAM.

I hope that answers/addresses your concerns, if not let me know.

Cody

>
>   -- Bruce Dubbs
>      linuxfromscratch.org
