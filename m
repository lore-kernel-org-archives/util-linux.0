Received: from dsmtpq2-prd-nl1-vfz.edge.unified.services (dsmtpq2-prd-nl1-vfz.edge.unified.services [84.116.6.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C1978F4A
	for <util-linux@vger.kernel.org>; Sat,  1 Nov 2025 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.116.6.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761991925; cv=none; b=PAmXnushz/IkWSGCNdgbgjXZIMG5LV+RfSzDHs0ByTUtYjwspWcY7aIvAETv/T/Q83OyB4bFZ3RgAdyuFSeyNDo+R4BxH06a4n3SiyxF/+foYolR2Hn0wGYQMHW2xWuxCtgbQYOx3avm6BacvZupjZqg3t+f1zavMOKtLp0TEk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761991925; c=relaxed/simple;
	bh=VzFNcsb94ee+q8IPxBCq/PxBRi+qn9coZXXA3+gQY48=;
	h=Content-Type:MIME-Version:From:To:Subject:Date:Message-ID; b=pq/Yi4hnPbxjRx1gSEmzVyFD/gcSm52RQC1shGMmy6WJ+kQU72lvKtQfmJ0xNDAOY6NJZqJ/B+fe7FR5NRPuK6H5huXQtOunh/81nZzl2mlZV0SujUHU/t7j6AH86RIkBpyPG2uW1KisM5UUOyad+BqM22kAmKdYon4P42UD3Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mrns.nl; spf=none smtp.mailfrom=mrns.nl; dkim=pass (1024-bit key) header.d=mrns.nl header.i=@mrns.nl header.b=QD3IubxW; arc=none smtp.client-ip=84.116.6.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mrns.nl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mrns.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mrns.nl header.i=@mrns.nl header.b="QD3IubxW"
Received: from csmtpq4-prd-nl1-vfz.edge.unified.services ([84.116.50.10])
	by dsmtpq2-prd-nl1-vfz.edge.unified.services with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <dick@mrns.nl>)
	id 1vF7CV-006L4t-Jq
	for util-linux@vger.kernel.org;
	Sat, 01 Nov 2025 09:43:07 +0100
Received: from csmtp5-prd-nl1-vfz.nl1.unified.services ([100.107.80.45] helo=csmtp5-prd-nl1-vfz.edge.unified.services)
	by csmtpq4-prd-nl1-vfz.edge.unified.services with esmtp (Exim 4.95)
	(envelope-from <dick@mrns.nl>)
	id 1vF7CN-001pTT-Uw
	for util-linux@vger.kernel.org;
	Sat, 01 Nov 2025 09:42:59 +0100
Received: from routi.mrns.nl ([213.93.239.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by csmtp5-prd-nl1-vfz.edge.unified.services with ESMTPSA
	id F7CNvBFNWM9UUF7CNvK1dS; Sat, 01 Nov 2025 09:42:59 +0100
X-Env-Mailfrom: dick@mrns.nl
X-Env-Rcptto: util-linux@vger.kernel.org
X-SourceIP: 213.93.239.227
X-CNFS-Analysis: v=2.4 cv=X95f6WTe c=1 sm=1 tr=0 ts=6905c813 cx=a_exe
 a=JHrq6bmmrihZf+Bww3MhDg==:117 a=JHrq6bmmrihZf+Bww3MhDg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=LQrtYbNyCH8A:10
 a=qMyuKC50n-BZmBaRMVQA:9 a=QEXdDO2ut3YA:10 a=HhbK4dLum7pmb74im6QT:22
X-Authenticated-Sender: ieb1yoh3@ziggo.nl
Received: by routi.mrns.nl (sSMTP sendmail emulation); Sat, 01 Nov 2025 09:42:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mrns.nl;
 i=@mrns.nl; q=dns/txt; s=mail; t=1761986579; h=content-type :
 mime-version : content-transfer-encoding : from : to : subject : date
 : message-id : from; bh=VzFNcsb94ee+q8IPxBCq/PxBRi+qn9coZXXA3+gQY48=;
 b=QD3IubxWAvgNKlX/gZZfVx53s1Jqm9T+pyLQa+zjipSU+m3een9UfskXXJny4BgrwXzey
 gc2timhwBNGHNv75aDzPvEk+28pcETWPtYloqXkJyjrKFKS7kKQTjJcdj0PBN/V8+ROEePK
 ZghFK94txg9n3xrpa0Al8IVK6IBIhN8=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Dick Marinus <dick@mrns.nl>
To: util-linux@vger.kernel.org
Subject: reflink utils
Date: Sat, 01 Nov 2025 09:42:59 +0100
Message-ID: <176198657938.2807.15997469587039898204@routi.mrns.nl>
User-Agent: alot/0.11
X-CMAE-Envelope: MS4xfKm0XvLiUSrgm4lwbQ37nHfkj074Fpe3FiDk3R/TlsVixD2t4sR94sTSpTnBsakWP+QklnCNCXp29YbMXSTTjPkmI4ZFQrNajMFME7axf4HBMeYwwQGZ
 Alz4hjM41XDqB8miY2IMIVnxTvY1XTCbzO2tJvYb/ZZc81gFIC2ld06ai3payNUMfFSPeDZQK3c5JA==

Hi,

I've created some tools to work with reflinks (FICLONERANGE) which I'd
like to include in the util-linux project.

Reflinks can be used to share equal blocks between files. Cloning a
block using reflinks will not copy any data saving I/O and disk wear/
space.

First tool is blkdiff which takes two files, a base file and a new file.=20
Then it creates both a delta file and an index, the delta file contains
the different blocks in new file compared to the base file and an index
file which contains the block indexes in either the base file or the
delta file so the new file can be constructed from that.

This is a bit similar to rdiff from librsync but uses fixed block sizes
and doesn't require the chunks to be in the same order. FICLONERANGE
only allows you to clone blocks of the filesystems block size.

The next tool is blkpatch which uses the base, index and delta file to
construct new file using reflinks.

I've also created blkcat which concatenates the blocks from all supplied
files using reflinks into a single file with the idea to use this as a
basefile to deduplicate files on a filesystem.

I think reflinks, or at least FICLONERANGE is linux specific so
util-linux would be a good fit. Reflinks are currently supported (AFAIK)
for BtrFS and XFS.

I'd love to know:

- can/should I contribute these to util-linux?
- are blkdiff, blkpatch and blkcat good names?
- what's required more? I can image I need to add some man pages etc.

I already found the Documentation/howto-contribute.txt which I would
use to contribute these utilities. GPL-2 is fine with me.

Kind Regards,
Dick
