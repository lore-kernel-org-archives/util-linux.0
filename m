Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.227]:20529 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750840AbbK0XU6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 27 Nov 2015 18:20:58 -0500
Subject: Re: Can not move tmpfs mounts
To: Karel Zak <kzak@redhat.com>
References: <56552586.2040007@ubuntu.com> <20151125093935.GF4955@ws.net.home>
Cc: util-linux <util-linux@vger.kernel.org>
From: Phillip Susi <psusi@ubuntu.com>
Message-ID: <5658E558.2010204@ubuntu.com>
Date: Fri, 27 Nov 2015 18:20:56 -0500
MIME-Version: 1.0
In-Reply-To: <20151125093935.GF4955@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 11/25/2015 04:39 AM, Karel Zak wrote:
> Are you sure the problem is tmpfs? I guess you have problem with 
> propagation flags (shared vs. private), probably systemd based
> system where all is shared by default.

I could have sworn it worked with an ext4 fs, but yea, you are
right... it is the shared flag.  Why can't you move a mount point when
it is in a shared namespace?


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCgAGBQJWWOVRAAoJEBB5UWFcu6UWRTgH/A8+RAOWPp5unIbUrWGZcLtv
g1aFe8+KZ9Ggpn7P3H3qg0eNh2S0SSqNQxz5XgJ4dw50SawdulBAqMx4rl4XmTaQ
260nE3ZRMF6r65k61DKh5m0baqP4duWtIB9uDBPWg4p/hx7fgZghHHqCbfm5o3Ig
Z2EqXZ/XIj+2n5JwpRiH4JNj3ahFUIGto3rCrlyIDEJ1G9C39ASNtu1YydvI/f+T
x04o19+Kp0elUM/HNfdinKBYPq4IR8tPSImjw4sC8VhFYx+hJTHznC6pzwJyzEN0
KKaQfn9bzEn33UMrytLIHC7S5mamU9EHAUx3xSj9i1soTqKwSVcIELMXOYq+V1Q=
=VtA4
-----END PGP SIGNATURE-----
