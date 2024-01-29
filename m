Received: from herc.mirbsd.org (bonn.mirbsd.org [217.91.129.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2000A15AAB1
	for <util-linux@vger.kernel.org>; Mon, 29 Jan 2024 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.91.129.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548361; cv=none; b=BFBAHRBRT87NZCUKXZAuefQOGVh4e7JCCuSmZhS/VlGMP0BLbC7V81cl6ywCE4trv5Vg0/1tkvFcToPP50P7BoEVPEW2GHyCS+8KFQ3sokJ9gcgHPalT1vB7MwU+cfwaYhI9AwBhOmww0lqoNwrh9Ll9eephwWByCQzLrQ0nPvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548361; c=relaxed/simple;
	bh=K+1gFrdXxZiGL4cEB0V9piIC3Sg2ltqlI91E7K1v8m0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=TAsEKo0xbkeMjGgfSUx/26MRkMypUhz6z5IeDQgvfd89PHFdxsbbHeAZcH1ksHRR/+EW8Fxb3EoQBU+j9c7PRjsliUkUhxVJqXypAo4tYjX6NVVSSFlKWeUsMQwiDVeSI0JpfBODHJrt5GD1nKfBbMG79B1NbKWwtpqgz1ApfwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; arc=none smtp.client-ip=217.91.129.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
	by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id 40TH4CWF006539
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <util-linux@vger.kernel.org>; Mon, 29 Jan 2024 17:04:19 GMT
Date: Mon, 29 Jan 2024 17:04:12 +0000 (UTC)
From: Thorsten Glaser <tg@debian.org>
X-X-Sender: tg@herc.mirbsd.org
To: util-linux@vger.kernel.org
Subject: fdisk corrupts data on USB stick
Message-ID: <Pine.BSM.4.64L.2401291659410.19873@herc.mirbsd.org>
Content-Language: de-Zsym-DE-1901-u-em-text-rg-denw-tz-utc, en-Zsym-GB-u-cu-eur-em-text-fw-mon-hc-h23-ms-metric-mu-celsius-rg-denw-tz-utc-va-posix
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Background: https://github.com/grml/grml/issues/205

Using fdisk 2.36.1-8+deb11u1 from util-linux to create an extra
partition on a USB stick on which I had previously written an
ISO 9660 image does something to the data on the stick to make
klibc fstype not recognise it as ISO 9660 any more. Specifically,
it corrupts some data at some location within the first 4 MiB of
the stick but outside of the first 512 byte of it, as restoring
those first 4 MiB then re-restoring the MBR to the state fdisk
had written makes it work again.

This is a data corruption bug. I expect fdisk to change precisely
the MBR and nothing else unless told so.

Is there a way we can make it not corrupt such media?

Thanks in advance,
//mirabilos
--=20
08:05=E2=8E=9C<XTaran:#grml> mika: Does grml have an tool to read Apple
     =E2=8E=9C    System Log (asl) files? :)
08:08=E2=8E=9C<ft:#grml> yeah. /bin/rm. ;)       08:09=E2=8E=9C<mrud:#grml>=
 hexdump -C
08:31=E2=8E=9C<XTaran:#grml> ft, mrud: *g*
