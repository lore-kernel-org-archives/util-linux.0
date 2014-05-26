Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.228]:26110 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751803AbaEZOXP (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 26 May 2014 10:23:15 -0400
Message-ID: <53834CAB.7080306@ubuntu.com>
Date: Mon, 26 May 2014 10:16:11 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: Fwd: Bug#747948: mount: should warn user when potentially incorrect
 fstab order
References: <20140513100450.GA1083@europecamions-interactive.com> <5372173E.7090002@ubuntu.com> <20140526102426.GF2968@x2.net.home>
In-Reply-To: <20140526102426.GF2968@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 05/26/2014 06:24 AM, Karel Zak wrote:
> On Tue, May 13, 2014 at 08:59:42AM -0400, Phillip Susi wrote:
>> Here is the problem: currently, at start, filesystems referenced
>> in fstab are mounted following their order in fstab. The problem
>> is, when
> 
> I have added a note to the mount man page.
> 
> Not sure if we want to add so complex fstab checking code to mount
> -a.

I didn't think so either...


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCgAGBQJTg0yrAAoJEI5FoCIzSKrwxFgH/3xx4mZKzEHnOLhn4q7riqXQ
6zVRGVPCPoZi2W//RSic+IsEQZhx99WelL929Zkm3PCi4haNr/IvpMqVXa1eUTeA
73y7rTz2Fwst6VFkLbw0nbKA9KngAjbxd7tSwV1cJcZsldzjWcGUnYSvJvschthG
wPs/2aIZygDCa9LLpdRf2m/nvAlQ3yCG41CF7hQfy1Er9LNxyFWlQv1b7Ikfb+Fy
8WORM1XXx5HjJya33M2ddrbkPSI11+thaxIrykJbphTCCqSDg40923MWFCLaCi1a
bSOHAqUcBhd7T0G68ceZlrcjn43gE/CgEqzMQ8pu0PQoJkqS4/9qGk3355Yiyc0=
=Ayow
-----END PGP SIGNATURE-----
