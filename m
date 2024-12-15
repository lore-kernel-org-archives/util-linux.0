Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E27819
	for <util-linux@vger.kernel.org>; Sun, 15 Dec 2024 03:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734232857; cv=none; b=Auud6b7euTUeN8AOSs6QuKsflYC0I2FWmrLVvKKZReIegyh87gFUj7UeyHOYHnrPI59Ca2hOfVsIhL45OmM0LcTw0n08KFcl87G+ROgw0sJEc6hpOQEMQL9LbHYz1Ji1cBulaHpREAcLp3JNQTgsXWEylIJ2uJpAP/gBKRIdOh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734232857; c=relaxed/simple;
	bh=5uU09X/B/0zg1C8eSXhzUuOOMCxAbIxbKs1F6yKtvd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4N25K0QaM4slXsZRH8F7aG3UGJenAWcJVLVvv1yCpu08P/JW6ky1w3g16VVoNXTkNf0SvkVT0mIUHY3veunVSYBQk6Zns5Ynij4HTcJPh18F7rb+hrRCbgeaOt8EE+wd6TXBKQlWZ+XSLWEoGq697UdjoXJO9oRKDU6nWJuy0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=lyrfKRWa; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="lyrfKRWa"
Received: from cwcc.thunk.org (pool-173-48-82-226.bstnma.fios.verizon.net [173.48.82.226])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4BF3Kgx7004555
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 14 Dec 2024 22:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1734232843; bh=kfDI3ADlfH2xL2cV35EXoPz+k9OWSXASgIuxqNbJRfc=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=lyrfKRWa+xWNuueyh+SJ+Aw4S3FicgxL8Wj/w2gmVLmorrs3ZcsWXGIvSOfv+NiYb
	 Ak/tKVEk+Wg26V/qZqX1ltLm0QJr7Ui2t0k+TPJwhCh1TEa97DF0pnm+1zdYlCp/Hm
	 qBgsMA4cJomq0ekxlU9DU1N/ddv3lF4XJNqIHwOKvrm10vVrL6Q+JkjUN/vFIj8qFF
	 meVfnAYFtLFj3HmPYqpXpLZXrJN1gjWw1sCybPp3NN+mpXUC9G3YG8VVL+nnWDl0HF
	 t4ZJUUExTSQm4tBhSnYCQuAq0FLqjEoPq6HCHp6q5Du3H040UNESejSddzZjfGsK8j
	 cBoyjEDljOPmA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id DC36115C4656; Sat, 14 Dec 2024 22:20:41 -0500 (EST)
Date: Sat, 14 Dec 2024 22:20:41 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: Ensuring that mount(8) will always interpret a filesystem
 correctly
Message-ID: <20241215032041.GC2472262@mit.edu>
References: <6f939e2c-7d86-4b3d-885b-2c171c944079@gmail.com>
 <zxqdvuyhtmas5apcnop7kleh2b24sboscyaosgkyqqfz4nlsdf@rmgdzivamwdw>
 <114fa16d-5908-4300-96a0-23203c7470af@gmail.com>
 <y7tl6b7pviy7ubstwprmw57ubquf777orkp56h45r7ab3xjfek@t3qjqzehfwnp>
 <155cef10-48b4-42f0-bacf-b9e1d7394206@gmail.com>
 <20241211133808.GB1912640@mit.edu>
 <d1ad846b-def1-403d-be62-aac78e06fdc3@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1ad846b-def1-403d-be62-aac78e06fdc3@gmail.com>

On Sat, Dec 14, 2024 at 05:08:54PM -0500, Demi Marie Obenour wrote:
> > From what I can tell, the Discoverable Partition Table specification,
> > at least as defined here[1] only supports explicit file system types
> > supplied by the GPT partition table.
> > 
> > [1] https://uapi-group.org/specifications/specs/discoverable_partitions_specification/
> 
> It’s the other way around: the GPT only provides the mountpoint,
> never the type.  That’s why I filed an issue [1] asking for
> per-filesystem-type UUIDs.

Bleah, you're right.  Other partition tables, including MBR(!) used
the "partiton type" to be the kind of file system.  (For example,
0x07h meant OS/2, 0x09 meant QNX/Coherent/OS-9, 0x0Bh meant FAT32 with
CHS addressing, 0x0Ch meat FAT32 with LBA, 39h meant Plan9, etc.)

When I saw "partition type" in the UEFI spec, I thought they were
seeing the path of wisdom and moving away from in-band signaling to an
explicit type specification --- but you're right, looking at the UEFI
spec more closely, it's about how the file system is to be used, not
the file system type.

(It's really not even the mount point, since
773f91ef-66d4-49b5-bd83-d683bf40ad16 means "per-user home partition",
but since the UUID doesn't specify the username, you would't know
whether it was supposed to be mounted in /home/lucy, or /home/snoopy,
or /home/charlie_brown.  Yelch....)

> I’m not too worried about this, and instead am of the opinion that it
> needs to be fixed on the blkid side (by ignoring the ZFS superblock).

I disagree; blkid's *job* is to detect the file system type, and just
ignoring all ZFS superblocks means that it won't be able to detect ZFS
file systems, which would be sad.  And having some kind of arbitrary
preference where blkid were to say, "well, if it's ambiguous whether a
block device is ext4 or btrfs or ZFS, I'll just arbitrarily say ext4
because I like ext4 more" is well, arbitrary.

The best way to solve this is to either have users use "wipefs -a
/dev/hdXX" before running a mkfs program, but in the spirit of being
kind to users[1] who don't know about wipefs, or for distro installers
that don't bother to call wipefs, I'm perfectly happy to teach
mkfs.ext4 how to make the right thing happen automatically.  I just
need to know how to zap ZFS superbloks.

BTW, in practice this happens automatically for SSD's, since we will
call BLKDISCARD on the entire device, for better FTL GC performance.
But for HDD's, we will need to explicitly write zeroes in the correct
location.

Cheers,

					- Ted

[1] Using a variation from Struck and White's "The Elements of Style"
where they said, "always write with a deep empathy towards the
reader", we should strive to program with deep empathy towards the
user.  :-)

