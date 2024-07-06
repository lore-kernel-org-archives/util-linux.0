Received: from mrkos.uberspace.de (mrkos.uberspace.de [185.26.156.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2CC6FC2
	for <util-linux@vger.kernel.org>; Sat,  6 Jul 2024 02:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720232267; cv=none; b=AOJrNP1OlVWaYBfwrydtjqYAxYS+u+LZWJm+3NsJCvqLTJHVKnLU702sNUYKMap9EBxys7cmICiW+I+0BQ/+L3DOM9E6PFQ1tKaVdTX4Oa1+3jsk54az5iRhO5kSM6NCo0Ge3pwY3o57ss8DgG5Dff0fzXdu/VQG7eiA5c4ehdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720232267; c=relaxed/simple;
	bh=NmvRfUlVs726MQJe2gzkuXhGTH43v47EIp6ibcc260Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=BYb194zk7Hup8wiMjbniGHF3I7mL2+0TusqMacpXqm3knj2rT6CbAawePehcBsEj6pZ9Ss7WGjqkyXpBqlJ6TCFCHKGIJOjAf2aFptHAvQ++fyfZaCkqZhBfUumHR/uyjucCOFPdd0B1fE62OeYyG58Vigwu7cn2cL6M2YRutNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lrose.de; spf=pass smtp.mailfrom=lrose.de; dkim=fail (0-bit key) header.d=lrose.de header.i=@lrose.de header.b=ruhbBTb4 reason="unknown key version"; arc=none smtp.client-ip=185.26.156.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lrose.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lrose.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=lrose.de header.i=@lrose.de header.b="ruhbBTb4"
Received: (qmail 11585 invoked by uid 990); 6 Jul 2024 02:17:43 -0000
Authentication-Results: mrkos.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by mrkos.uberspace.de (Haraka/3.0.1) with ESMTPSA; Sat, 06 Jul 2024 04:17:43 +0200
Date: Sat, 06 Jul 2024 04:17:30 +0200
From: lukaro <lists@lrose.de>
To: util-linux@vger.kernel.org
Subject: lsblk: mount point in btrfs raid
User-Agent: K-9 Mail for Android
Message-ID: <48C84F1A-9A8A-4E02-8E32-B171461DC0CC@lrose.de>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Bar: --
X-Rspamd-Report: BAYES_HAM(-2.857339) MIME_GOOD(-0.1)
X-Rspamd-Score: -2.957339
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lrose.de; s=uberspace;
	h=from:to:subject:date;
	bh=NmvRfUlVs726MQJe2gzkuXhGTH43v47EIp6ibcc260Y=;
	b=ruhbBTb4X8Q8EULIaB3A6QIn9+cDv2z5LvQk/+wPUTpB49Da6fw0bfsrHLrUidCNFk+qdLHBpL
	tu/eAjPF/+he0lvg0bBriM5GXaX9x0dmUv89u6oeun+aDqyEePYioyoCUvShJLk8n4xbnUPtaolD
	cY4Iv8zXeFhxZKokdOhXe9JvxDP0Fq5CDB0xM0XXyglJc4ty6gzNMP86mz0JzsBjjspfAQhI00Ak
	YwROviAcRzeO4aveXZRmDMyGCcTy+NlRn1u/D7Zu7a2ps9wBtsnccIOzPf9gjk7hYXUaC66CH/XY
	jFQyjExpu3CgL9pkpryv2YlRaFiIQmJFdN1VPbctoC8J4VHGBvXx98ePcvRIv+xCB1WCgOG4Qc9a
	CXeQG0mx6ASw0ftAxggcDQ+tyfGqc1A7JZM81chHUZyWv2SmPLADeTcFyYsZPKvgbu6w+vWtJLXo
	Cn1HYWi+zw6dUWLF3NE2L2Lq3ky1FaDYOZRB+BSc0FDSEkP3NuYgMI+hQI+kPF7RUflvkpNH25v/
	0c2C9yCXDLL1xJ+8gnDVM7UwqyruWBJlCutw8KeptweJnmoWaRjRQnSUz3m0CMtlij1cgI1RTkeA
	fmMK6ptFdTISCaO5mBr77hAAV8e0POBNl61qIUguqQn9xLDQ3MJ4ta67GJFMYjzHFp+3kYJd/fsR
	I=

Hi everyone,

in lsblk, I'm used to seeing the mount point for all devices in an mdadm r=
aid, like so:

sdb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 8:16=C2=A0=C2=A0 0=C2=A0 16=2E4T=C2=A0 0 disk
=E2=94=94=E2=94=80sdb1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 8:17=C2=A0=C2=A0 0=C2=A0 16=2E4T=C2=A0 0 part
=C2=A0 =E2=94=94=E2=94=80md127=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 9:127=C2=A0 0=C2=A0 32=2E8T=C2=A0 0 raid5 /store/RAID_A
sdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 8:32=C2=A0=C2=A0 0=C2=A0 16=2E4T=C2=A0 0 disk
=E2=94=94=E2=94=80sdc1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 8:33=C2=A0=C2=A0 0=C2=A0 16=2E4T=C2=A0 0 part
=C2=A0 =E2=94=94=E2=94=80md127=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 9:127=C2=A0 0=C2=A0 32=2E8T=C2=A0 0 raid5 /store/RAID_A
sdd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 8:48=C2=A0=C2=A0 0=C2=A0 16=2E4T=C2=A0 0 disk
=E2=94=94=E2=94=80sdd1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 8:49=C2=A0=C2=A0 0=C2=A0 16=2E4T=C2=A0 0 part
=C2=A0 =E2=94=94=E2=94=80md127=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 9:127=C2=A0 0=C2=A0 32=2E8T=C2=A0 0 raid5 /store/RAID_A

However, with btrfs raid, the mount point is only shown for the first devi=
ce:

sdf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 8:80=C2=A0=C2=A0 1=C2=A0 7,3T=C2=A0 0 disk
=E2=94=9C=E2=94=80sdf1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 8:81=C2=A0=C2=A0 1=C2=A0 7,3T=C2=A0 0 part
=E2=94=82 =E2=94=94=E2=94=80video_4b0=C2=A0 254:4=C2=A0=C2=A0=C2=A0 0=C2=
=A0 7,2T=C2=A0 0 crypt /mnt/video
=E2=94=94=E2=94=80sdf2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 8:82=C2=A0=C2=A0 1=C2=A0=C2=A0 28G=C2=A0 0 part
sdg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 8:96=C2=A0=C2=A0 1=C2=A0 7,3T=C2=A0 0 disk
=E2=94=9C=E2=94=80sdg1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 8:97=C2=A0=C2=A0 1=C2=A0 7,3T=C2=A0 0 part
=E2=94=82 =E2=94=94=E2=94=80video_5f2=C2=A0 254:5=C2=A0=C2=A0=C2=A0 0=C2=
=A0 7,2T=C2=A0 0 crypt
=E2=94=94=E2=94=80sdg2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 8:98=C2=A0=C2=A0 1=C2=A0=C2=A0 28G=C2=A0 0 part
sdh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 8:112=C2=A0 1=C2=A0 7,3T=C2=A0 0 disk
=E2=94=9C=E2=94=80sdh1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 8:113=C2=A0 1=C2=A0 7,3T=C2=A0 0 part
=E2=94=82 =E2=94=94=E2=94=80video_666=C2=A0 254:6=C2=A0=C2=A0=C2=A0 0=C2=
=A0 7,2T=C2=A0 0 crypt
=E2=94=94=E2=94=80sdh2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 8:114=C2=A0 1=C2=A0=C2=A0 28G=C2=A0 0 part
sdi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 8:128=C2=A0 1=C2=A0 7,3T=C2=A0 0 disk
=E2=94=9C=E2=94=80sdi1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 8:129=C2=A0 1=C2=A0 7,3T=C2=A0 0 part
=E2=94=82 =E2=94=94=E2=94=80video_9b1=C2=A0 254:7=C2=A0=C2=A0=C2=A0 0=C2=
=A0 7,2T=C2=A0 0 crypt
=E2=94=94=E2=94=80sdi2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 8:130=C2=A0 1=C2=A0=C2=A0 28G=C2=A0 0 part

Where in the sysfs does lsblk obtain the mount point information? Is it po=
ssible that the btrfs module is lacking this information? I would like to u=
nderstand why lsblk is lacking this information for btrfs=2E

Thanks in advance,
lukaro
