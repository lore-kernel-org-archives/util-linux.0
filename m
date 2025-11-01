Received: from dsmtpq1-prd-nl1-vfz.edge.unified.services (dsmtpq1-prd-nl1-vfz.edge.unified.services [84.116.6.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90C520C463
	for <util-linux@vger.kernel.org>; Sat,  1 Nov 2025 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.116.6.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761992092; cv=none; b=fhLf3rpyQmpxsiBifCtQrNPUpUC6hsN50PSUzXTG84SqQrjZxfXa9i0ojzkM95lz7kbREBG7AXxo6GrOqv95c9OAgFDYT/OS3amI3hhQZ1IBSexphKxU4Ul7tlfKn/KYk4Jq5pAIGfGd32ZUS5E72HrdawdPDZPcjtRFPpLOahg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761992092; c=relaxed/simple;
	bh=VzFNcsb94ee+q8IPxBCq/PxBRi+qn9coZXXA3+gQY48=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:To:
	 Date:Message-ID; b=osCQLr7pIzGrUBOki1qqLlhIGu1z9LE8HadoEPl7klgdyXHgEOaOo8T8F/VqgguwavWiAKdBHgsOL8hbHu8Qae2ird+lXQx1b0pMs4646NJbeVfhpoT4cEcLBHs+75eB/BEdA3QV0+aQM6tYdhKsDMNn/4YDjbVf2d2pjJFOwbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mrns.nl; spf=none smtp.mailfrom=mrns.nl; dkim=pass (1024-bit key) header.d=mrns.nl header.i=@mrns.nl header.b=CryKyvth; arc=none smtp.client-ip=84.116.6.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mrns.nl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mrns.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mrns.nl header.i=@mrns.nl header.b="CryKyvth"
Received: from csmtpq2-prd-nl1-vfz.edge.unified.services ([84.116.50.17])
	by dsmtpq1-prd-nl1-vfz.edge.unified.services with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <dick@mrns.nl>)
	id 1vF7R2-006HZ3-R1
	for util-linux@vger.kernel.org;
	Sat, 01 Nov 2025 09:58:08 +0100
Received: from csmtp5-prd-nl1-vfz.nl1.unified.services ([100.107.80.45] helo=csmtp5-prd-nl1-vfz.edge.unified.services)
	by csmtpq2-prd-nl1-vfz.edge.unified.services with esmtp (Exim 4.95)
	(envelope-from <dick@mrns.nl>)
	id 1vF7Qv-00271b-44
	for util-linux@vger.kernel.org;
	Sat, 01 Nov 2025 09:58:01 +0100
Received: from routi.mrns.nl ([213.93.239.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by csmtp5-prd-nl1-vfz.edge.unified.services with ESMTPSA
	id F7QuvBJNsM9UUF7QuvK26D; Sat, 01 Nov 2025 09:58:01 +0100
X-Env-Mailfrom: dick@mrns.nl
X-Env-Rcptto: util-linux@vger.kernel.org
X-SourceIP: 213.93.239.227
X-CNFS-Analysis: v=2.4 cv=X95f6WTe c=1 sm=1 tr=0 ts=6905cb99 cx=a_exe
 a=JHrq6bmmrihZf+Bww3MhDg==:117 a=JHrq6bmmrihZf+Bww3MhDg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=LQrtYbNyCH8A:10
 a=qMyuKC50n-BZmBaRMVQA:9 a=QEXdDO2ut3YA:10 a=HhbK4dLum7pmb74im6QT:22
X-Authenticated-Sender: ieb1yoh3@ziggo.nl
Received: by routi.mrns.nl (sSMTP sendmail emulation); Sat, 01 Nov 2025 09:58:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mrns.nl;
 i=@mrns.nl; q=dns/txt; s=mail; t=1761987480; h=content-type :
 mime-version : content-transfer-encoding : in-reply-to : references :
 subject : from : to : date : message-id : from;
 bh=VzFNcsb94ee+q8IPxBCq/PxBRi+qn9coZXXA3+gQY48=;
 b=CryKyvthtL44e182KMQtEpabLs9xOC7ct+RQDScHA09BlVex1Zdp9gTSrUan6CvwiwZFq
 1nNWG8ryt44xqS1awvJwGHabaeQX+m2PFPn/O0MFR29polgpOOc/R10S+698jsHuHPNjdhf
 bRv1uRF272ZZU9/CyLtcZzaEJYnARrM=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <176198657938.2807.15997469587039898204@routi.mrns.nl>
References: <176198657938.2807.15997469587039898204@routi.mrns.nl>
Subject: reflink utils
From: Dick Marinus <dick@mrns.nl>
To: util-linux@vger.kernel.org
Date: Sat, 01 Nov 2025 09:58:00 +0100
Message-ID: <176198748059.2807.11081418836958336252@routi.mrns.nl>
User-Agent: alot/0.11
X-CMAE-Envelope: MS4xfCaOtuIyuAqaRQF00bR/a3o7NDvZPaNo9zs8eDcyusAKCriO71lBMU3DILEdtWo7YnJtt0hwsMOMQx3qGGhfl9nyQtcY/axVbVDtUoUAzs19qnjTl7Wl
 shVhfAjPeyIO6/UDYqC7X8namH+Ep7e+EgEla1/v2+DAfwOStBAAjjYoeO1LQaWdn4Jpa+7kLXRfvA==

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
