Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CA61DFDB5
	for <util-linux@vger.kernel.org>; Tue, 17 Dec 2024 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426837; cv=none; b=C1XBPqOEP2FbinY9gm3VGFr5bYx061LMKXgKAwnXjigi77n3VIZOoibKWRbdtg2jryjGoNy14NfWhZ65SgpJjA1dTTDeVp0wTU1V+IRYqrrsfQmZUS60iRWSUY6AmWIc3As43/iJIqo45d52L2n+2MHSVmWQrv7jc/769DEuhJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426837; c=relaxed/simple;
	bh=VCuSD6iN0r7zRiYPeL+DD9+U5HyCxCy4G8HvEAvarlQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mDy21+EgCsCNYbzwMC1Vas5NJFBu6slx5MRJYgTXQpJ148lW1FlxXc1g8r1FHDMM8EeLJyThOCiyigBlhCeZlAdTi7afiumx2jr4fMZJh1pFoNRyuKtIdjFo/bCZXTRxYaMACglssTuOADAtQtukrKA93mS8H4+rO4naws8uLFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=chdOOp8z; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="chdOOp8z"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385de9f789cso3979730f8f.2
        for <util-linux@vger.kernel.org>; Tue, 17 Dec 2024 01:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734426834; x=1735031634; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCuSD6iN0r7zRiYPeL+DD9+U5HyCxCy4G8HvEAvarlQ=;
        b=chdOOp8z7Lg84vHLxsDsx5D+QsJbMiD+JhND7jy4IVJxQprJdKLjZ306OS4jn1kSba
         id5wRs0Yz7ro3Q4tu0x+ziMukpm7UEe8UPiGJjdOKOmpHgizwPDDzgcfgj6vY3s1Yl4v
         1kekUczbpBRtvhw3QsZA5Bw27wRz4SfWZTlYh4JO80JHplqS/o0ZVFiF1DD84Rj13zWU
         DjJCoFaqD+s2+DUJ/YytPAzJcFV4y1jxV3JvXTfSInukOoZNyHVmV/nJnRBAYjtyZ7yA
         kd/rHmIJYpqMNvV79YMvKWnT8fEWPh2H092lEpN5OJI7/1dKVYZb/gvLuaF74Un1IB0F
         lJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734426834; x=1735031634;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCuSD6iN0r7zRiYPeL+DD9+U5HyCxCy4G8HvEAvarlQ=;
        b=BOq2v/wImxDIaPB2t6TNiLOGdmBFgeA5aHZ/pUNwQfrmW9ZP4IYn8uaSzL3qmvSngQ
         RWPy+Htptj508omnLssie+mn39pRqnx9ofbiBakdqRGJUbMJaDRtJyYcO0WBwA5ZaS/w
         ji7EI+/joINlOWUDRRiYeCqHv/mmxXkjUoSVtcsgNk4L0cnRNHOGWNEKqnTOITdaQePX
         Ur5XyL/o84b3FfGhdL0OXHh5IC0MWyJfqSA20ZL7hpKTyAelquNMQW8zfR+hOl1V7s4i
         lK8Z39neqCOqbD9pWgVkfSJoZbcxr18vHmjaMme8Hcxf5cdac0tH/ycuTabMdULaTOaW
         7WEA==
X-Forwarded-Encrypted: i=1; AJvYcCXgTSU7i9UF9z1/Al2ZgTW97PJUEY96vxbldEEH/tMpNafNhPhNg8hZX/yZxEwpEpnT+lspuD+q94oI@vger.kernel.org
X-Gm-Message-State: AOJu0YymVBnOzr2j/07l4HPA6KCPPprmJ896TNcsQpNvJKgK2xmuT3jT
	8a60P21/vEh4EiFRW1RJgYUPNDuVOWj/hAkVVoxW053tVv/acgaTxrAi/yQ/u0w=
X-Gm-Gg: ASbGnctoOEeAvGGR7HC+uzmyc3quUSR8+afpSSP/OLqpjPsuLDVw+fSfxCK1usOQIcr
	sUCbGSrlDcm5zoIMFfX6P5yeySArA2ACShnEF6XEahPxjC9t4m9riEfa/rPzRuHuedzJRC3UwZb
	r7jewUdrN7B7NhWezibkZUHG7IzH2EHaBn6TyoPTdVdRfkHG91hO967ilbJANcbj+UbH0MeMGRz
	WWjAh5VePwAQx156q18KIHP4oebmqUwngBX4XN61dqgT+dWZKfUDNT2qJI=
X-Google-Smtp-Source: AGHT+IEmjueppPxkc1ixQCoP7RZ55j3RkoL/jeN4uTWnzjFdH2Q4QiD5417kzjOJQLP/zMRVSMYfww==
X-Received: by 2002:a5d:584a:0:b0:386:42a6:21f2 with SMTP id ffacd0b85a97d-38880af1406mr14843885f8f.10.1734426833837;
        Tue, 17 Dec 2024 01:13:53 -0800 (PST)
Received: from smtpclient.apple ([47.243.38.206])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a90f36sm5415053a12.14.2024.12.17.01.13.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2024 01:13:53 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: is it possible to add a new filter to detect unusable partition
 types
From: Glass Su <glass.su@suse.com>
In-Reply-To: <826b5136-7ee1-4664-98d6-a3441883f53e@suse.com>
Date: Tue, 17 Dec 2024 17:13:39 +0800
Cc: "linux-lvm@lists.linux.dev" <linux-lvm@lists.linux.dev>,
 mchang@suse.com,
 grub-devel@gnu.org,
 util-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <43D73CB9-32E4-405E-93A9-E985C94F4A9E@suse.com>
References: <826b5136-7ee1-4664-98d6-a3441883f53e@suse.com>
To: Heming Zhao <heming.zhao@suse.com>
X-Mailer: Apple Mail (2.3826.200.121)


> On Dec 17, 2024, at 16:34, Heming Zhao <heming.zhao@suse.com> wrote:
>=20
> Hi LVM2 maintainers,
>=20
> One of SUSE's customers encountered an issue with LVM2. The user =
created several partitions, one of which was marked as "BIOS boot" (4) =
instead of "LINUX LVM" (8E). Subsequently, the user ran =
pvcreate/vgcreate/lvcreate on this partition. During a system update, =
grub2-install installed GRUB2 in the "BIOS boot" partition, resulting in =
LVM2 metadata corruption.
>=20
> The root cause of this issue is that grub2-install targets the "BIOS =
boot" partition when this lvm2 device is specified for installation. If =
the user had initially marked the partition as "LINUX LVM", =
grub2-install would not have chosen this partition.
>=20
> On the other hand, it would be beneficial if LVM2 could implement a =
new filter or a filter function to detect and exclude the "BIOS boot" =
partition from being considered a valid target for LVM2 device creation. =
This could involve issuing a warning or error message to alert the user =
of the potential conflict. This may also help user to notice the issue =
more easily.
>=20
> Best regards,
> Heming

Also Cc util-linux@vger.kernel.org and grub-devel@gnu.org as it=E2=80=99s =
not an issue with lvm but also other fs progs.
It would be great if we can enhance libblkid to avoid data loss even =
caused by user mistakes.

=E2=80=94=20
Su=
