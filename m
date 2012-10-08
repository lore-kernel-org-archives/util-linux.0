Return-Path: util-linux-owner@vger.kernel.org
Received: from mx4-phx2.redhat.com ([209.132.183.25]:50078 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200Ab2JHP6E (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Oct 2012 11:58:04 -0400
Date: Mon, 8 Oct 2012 11:58:02 -0400 (EDT)
From: Miloslav Trmac <mitr@redhat.com>
To: Cody Maloney <cmaloney@theoreticalchaos.com>
Cc: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Message-ID: <1602327413.10922833.1349711882201.JavaMail.root@redhat.com>
In-Reply-To: <CA+K3q6or0gEB_FUYaL4ktVZjWikAWQhb4tQNfQgcFfnLZ54guw@mail.gmail.com>
Subject: Re: Adding support to chsh for non-local shell modification
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

----- Original Message -----
> Looking at chsh, it definitely looks like it should be relatively easy
> to utilize libuser within it and add a configure for disabling the
> dependency. If it's okay with both maintainers, both lchsh and chsh
> are licensed under the GPL so I'd like to just merge lchsh's code into
> chsh (rather than try to write what should be pretty much exactly the
> same thing from the API documentation).

Yes, that sounds reasonable.  There don't seem to be command-line argument differences, perhaps we might end up with lchsh a symlink to chsh (as long as that can be done compatibly).

> If you both approve I'll start working on writing the necessary
> patches, first adding support to chsh, then, once those patches are in
> a happy state, implementing chfn using the same method.

Please keep me Cc:ed on the patches.

Let me add just a few notes:

1) If (!lu_uses_elevated_privileges()), the program should drop all privileges and skip the PAM authentication.
2) Until either the privileges are dropped or the PAM auth is performed, the program should be extremely paranoid about passing untrusted data to libuser.
3) For even more paranoia, clear LIBUSER_CONF from the environment before doing anything with libuser.
    Mirek
