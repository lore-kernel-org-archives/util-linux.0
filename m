Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:34081 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568Ab3KSPBd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 19 Nov 2013 10:01:33 -0500
Message-ID: <528B7D4C.1030405@ubuntu.com>
Date: Tue, 19 Nov 2013 10:01:32 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] setsid: don't fork
References: <1384456993-3721-1-git-send-email-psusi@ubuntu.com> <20131119132412.GG5572@x2.net.home>
In-Reply-To: <20131119132412.GG5572@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/19/2013 8:24 AM, Karel Zak wrote:
> Yep, it was our goal to not change the default behaviour that
> exists for years.

It isn't really a default preference but a straight up bug since the
behavior depends on how the shell invokes it.  You only get the no
wait behavior when it is a process group leader.  When invoked not as
a group leader, then you get the wait behavior whether you asked for
it or not.  So if you really want no wait to be the default behavior
then you need to fork whether or not you're a group leader and the
policy decision chooses whether to wait for the child or not.

> It does not seem too elegant :-) If you really want to change the 
> default behaviour than it would be better to make --wait default 
> and exec() in child, then you don't need setpgid(), kill() and 
> sleep/pause() at all.

What's not elegant about it?  I think it's cleaner than keeping around
a useless intermediary process that just waits for the child and
returns its exit status.  I'm still not sure why the kernel requires
you to not be a group leader but this seems like a better workaround
than forking off a lost child.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSi31MAAoJEJrBOlT6nu75Hd4H/2zwoBVn/wFbKfbTCMKxXg/i
80+PwDicDX3hnsU4RgSfi7AvqWJkiMBabSYg6aPE8f1HpKCxRDhdOg3wGP2a3Xj6
wZJRMLmVfxVW+bC0IuWU9unnsGmLF35OGfUMM1oNc0f3pdMPtMG80nV3FTwWints
cP4YoAaHa3DC+yV0e7hxtLDqJVwx6xlRVu5B9eo/uOk/GCnJ4Hv0Zj+4Ff/FF6LV
07dbSqt6glXLc1IIuja19qxpJL2xT/tQ0+723zNK3JiDdM6zSQ+0IGTRZw+/HhD+
kjtWQWxXSCRGj/bHcotJpwJ8qmNW7/gTGEpZk7lUNAEMH2OzNN9+2uIA7PD7hxk=
=UgK/
-----END PGP SIGNATURE-----
