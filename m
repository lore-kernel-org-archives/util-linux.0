Received: from dsmtpq4-prd-nl1-vfz.edge.unified.services (dsmtpq4-prd-nl1-vfz.edge.unified.services [84.116.6.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F3C3644B3
	for <util-linux@vger.kernel.org>; Tue, 10 Mar 2026 07:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.116.6.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129127; cv=none; b=BuZEG3bhMCn7RpLjzkpQFK0Wh5jVDtf2/ocqypudVemX0XTYgTGAiATtOTiXm52eYkUUZxhcicAz2aWuisrwP7c4Ah/oUPrpJBbmlu8YI/7N/pL8gRfceVrvw9K1M6GXemaI6jUJoocxXWtmdTe5++gbuU3RHsbLYb92s/9cIws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129127; c=relaxed/simple;
	bh=SoBgsrRXrEDBfDAwTManJZY28675857deiNp/s2WUvU=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=DgIjH8esoR/aXX5jyGfpx4wLKfjKGN7ueJRIfgRgbREbNIspjyeYunDpjksfOn8JIveWMgKMr9vJuIQQT3DDWfjkqTt2w0IwKiLeaDAdTioUsq5+BkieN9Umq4CV6T/geYD7pGumJODP6TZbCYBlLa1yvHPTjmbhMeCAx3++rZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mrns.nl; spf=none smtp.mailfrom=mrns.nl; dkim=pass (1024-bit key) header.d=mrns.nl header.i=@mrns.nl header.b=HHLu+AiZ; arc=none smtp.client-ip=84.116.6.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mrns.nl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mrns.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mrns.nl header.i=@mrns.nl header.b="HHLu+AiZ"
Received: from csmtpq4-prd-nl1-vfz.edge.unified.services ([84.116.50.10])
	by dsmtpq4-prd-nl1-vfz.edge.unified.services with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <dick@mrns.nl>)
	id 1vzroK-00CjQf-MZ
	for util-linux@vger.kernel.org;
	Tue, 10 Mar 2026 08:47:24 +0100
Received: from csmtp5-prd-nl1-vfz.nl1.unified.services ([100.107.80.45] helo=csmtp5-prd-nl1-vfz.edge.unified.services)
	by csmtpq4-prd-nl1-vfz.edge.unified.services with esmtp (Exim 4.95)
	(envelope-from <dick@mrns.nl>)
	id 1vzroC-00De1Q-GI
	for util-linux@vger.kernel.org;
	Tue, 10 Mar 2026 08:47:16 +0100
Received: from routi.mrns.nl ([85.147.219.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by csmtp5-prd-nl1-vfz.edge.unified.services with ESMTPSA
	id zroCvMk7YeS3pzroCvRiM8; Tue, 10 Mar 2026 08:47:16 +0100
X-Env-Mailfrom: dick@mrns.nl
X-Env-Rcptto: util-linux@vger.kernel.org
X-SourceIP: 85.147.219.207
X-CNFS-Analysis: v=2.4 cv=NebWEWD4 c=1 sm=1 tr=0 ts=69afcc84 cx=a_exe
 a=QfPJp9Xx0fncKAcDTfo4/A==:117 a=QfPJp9Xx0fncKAcDTfo4/A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=LQrtYbNyCH8A:10
 a=1rOlcF-JzrcUQ1hiaewA:9 a=QEXdDO2ut3YA:10
X-Authenticated-Sender: ieb1yoh3@ziggo.nl
Received: by routi.mrns.nl (sSMTP sendmail emulation); Tue, 10 Mar 2026 08:47:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mrns.nl;
 i=@mrns.nl; q=dns/txt; s=mail; t=1773128835; h=content-type :
 mime-version : content-transfer-encoding : in-reply-to : references :
 subject : from : cc : to : date : message-id : from;
 bh=SoBgsrRXrEDBfDAwTManJZY28675857deiNp/s2WUvU=;
 b=HHLu+AiZw82kbqT75woYhyBc6AbclEFLO+q3zAWQv7XrDHiYF3s3hhpyHguZuC2Wdpsok
 faGyRHWhWB/ge5JCFq0F+ksvS7LBPKo7gkIzUjq76Atzm025EpPLZo60fhifoFMTBcRW0fL
 mnVV0uGvxeU7QOHQqEVNQKEoDqFbYOc=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260309160903.15490-2-bensberg@telfort.nl>
References: <20260309160903.15490-1-bensberg@telfort.nl> <20260309160903.15490-2-bensberg@telfort.nl>
Subject: Re: [PATCH 2/2] copyfilerange: (man) correct the markup and improve the wordings
From: Dick Marinus <dick@mrns.nl>
Cc:
To: Benno Schulenberg <bensberg@telfort.nl>, util-linux@vger.kernel.org
Date: Tue, 10 Mar 2026 08:47:15 +0100
Message-ID: <177312883579.3137133.9262096927051904264@routi.mrns.nl>
User-Agent: alot/0.12
X-CMAE-Envelope: MS4xfBmMwD8baOxHIV4QtMYQaD5/Ysc7gyt8djtXeU3jQij8dNQ0woDA2H5XWB0yuQoJytwrKXKu94peUgdqZSxZrUS4tQTkjvbFK96fYjVKgFnaPj2P63he
 PrvkrejI9Zlfucfu2i4UgnkoR4wYlmsaJsxbdqHl/H1MyRv0YrN01VdMFlvHh9SQi/ZxB9pxzLJDMxb2/YN+lHtLfUSxOIdGcA02qcHljW2GFFhsUGzqwCVk

Hi Benno,

Thank you for cleaning up the documentation for copyfilerange, much
better!

Kind regards,
Dick Marinus
