Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:60609 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189Ab3KDOHK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 4 Nov 2013 09:07:10 -0500
Message-ID: <5277AA0C.70309@ubuntu.com>
Date: Mon, 04 Nov 2013 09:07:08 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: external mount utilities and utab
References: <5273FF29.1090403@ubuntu.com> <20131104133735.GH23604@x2.net.home>
In-Reply-To: <20131104133735.GH23604@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Are you saying then that all of the helpers should now be using
libmount, and taking care of the utab updates themselves rather than
just having mount do it?

On 11/4/2013 8:37 AM, Karel Zak wrote:
> On Fri, Nov 01, 2013 at 03:21:13PM -0400, Phillip Susi wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> When mount runs mount.cifs, /run/mount/utab is not updated, so
>> the user mount flag is lost and thus, I can't umount as the user.
>> Running mount -i works correctly.  Is this a bug in mount.cifs,
>> or should mount be recording these options whether it runs the
>> external helper or not?
> 
> ah.. note, that mount.cifs is not suid on Fedora, only suid mount 
> helper is mount.nfs on my machine.
> 
> Karel
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSd6oMAAoJEJrBOlT6nu759zQH/ApS7k10RDvYNgByirfu97gY
anSEcvn2nSBH4RXxiN2ugSlVtYPpr4HAZrxD0tYfb1BGH/0q1KI6RwlOlih9DSvf
kc6+iXRBU6eBVgaGWUeNWc9TVuSN9s/Ifw63dKkwppq6smLn4K6vnn1AcR3vy23c
BQw7wqdZZobsdMgiijDqKV0uT0VHEjH5lTDWkJ89fvJiC4/lvi1aL5AeKndOgusP
PuTrF9inji1lTbtK7r3gVoVPwl9b+YvzcsWG91OfbR77ACtM+OwC8kJZHxjI8AAu
4/x1OHI0yiz9kkMYDZDOfGj3lYrTc2aJ+tksDu89wFERnC8SOhv0HpsoY/6ANSw=
=0XY3
-----END PGP SIGNATURE-----
