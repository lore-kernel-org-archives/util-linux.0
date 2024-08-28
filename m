Received: from globelaneexpress.com (globelaneexpress.com [31.220.3.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FC6166F18
	for <util-linux@vger.kernel.org>; Wed, 28 Aug 2024 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.220.3.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724838129; cv=none; b=Fp1MmzZt+PQFaFM98IyDR73yP1eaU1NnMPmHMeO2WTPrBbVb8w/7sR6M4RZval/usJFvVNnmvY6N/0cdOKGETz8zOCPxn05buv540PriPFbYTN2Z6oGkaIZ6hv/wsE+gjkoZdVEUlrugnRYkeiKIaaYzWtjfx1Yhk3uuB1HiZhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724838129; c=relaxed/simple;
	bh=jGlQjVgShWaVNPBUuyRUOk56Om/DWzPsx99tbSnuIvE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iKqJ9pzVUSJ/QBOfBdocAjq2gtqvjgB/RCsfP27MPg0AblUgeuz3KjO2pv92ewKad5fYi0PF0LAOZgWDIJ7Csr/IEN0NBalQ/mnTaUtfsZhIzN9t9adgGRVIIhmx3tsfXUwHOv9hOGgghySfsFga6Zl14oqoJVIkZv0FHv1KU6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unitytrustfinancial.com; spf=pass smtp.mailfrom=unitytrustfinancial.com; dkim=pass (2048-bit key) header.d=unitytrustfinancial.com header.i=@unitytrustfinancial.com header.b=qE+ioeh9; arc=none smtp.client-ip=31.220.3.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unitytrustfinancial.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unitytrustfinancial.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unitytrustfinancial.com header.i=@unitytrustfinancial.com header.b="qE+ioeh9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=unitytrustfinancial.com; s=default; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OhbKwx+DBwme6pCk0eKZ/IMpViUnoaxYBuEZkAtNlfE=; b=qE+ioeh9LvApqHq70uCYcgtlc8
	D8bks7yfyupALMJotLd5USpHsACr34WVPgMo7Kyi8pHnr8Qz1QXe9S0PzLS2ROouX26RJn/fIunAl
	iiYZXsMeUza2Aeh6RDr62EjTPoxOF2/tmolaO12PCKO2KRb4c25roXTVvk+qgDCpFuI+YHId6v452
	39yJDMnfSMfkmKIRAXsPLXL77NCCegj5KaUi6fFFRZ5T9zs9SRl3XUYQY9WQlihTE9CMr0HmNuFmr
	x3L7xl0ZCsM4EFrZBldLRpSCCR4CG6rgZRRV7+/N2ZIMMsD6w+FcGeJC5UIk9iks+cQAMApUtnYUO
	GRe8WYlg==;
Received: from [84.38.132.26] (port=49607)
	by nl6.nlkoddos.com with esmtpa (Exim 4.96.2)
	(envelope-from <inquiry@unitytrustfinancial.com>)
	id 1sjFBU-00Cqfe-3D
	for util-linux@vger.kernel.org;
	Wed, 28 Aug 2024 11:42:03 +0200
Reply-To: vivian@internationaluniforms.com
From: Vivian <inquiry@unitytrustfinancial.com>
To: util-linux@vger.kernel.org
Subject: Request For Inquiry
Date: 28 Aug 2024 12:42:04 +0300
Message-ID: <20240828124204.66D3E4F08A02ACDE@unitytrustfinancial.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nl6.nlkoddos.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - unitytrustfinancial.com
X-Get-Message-Sender-Via: nl6.nlkoddos.com: authenticated_id: inquiry@unitytrustfinancial.com
X-Authenticated-Sender: nl6.nlkoddos.com: inquiry@unitytrustfinancial.com

Dear Supplier

Nice to contact you again
Hope this mail find you well

We are interested in importing your product
i would like to place an order from your company this month,

kindly send me your catalogue and price through our E-MAIL or=20
skype,
Please treat this as urgent

thanks

Purchase Manager vivian

Email: vivian@internationaluniforms.com
Beim Strohhause 2
20097 Hamburg =E2=80=93 Germany
Phone:  +49/40/284 24-321
Fax:  +49/40/284 24-236
