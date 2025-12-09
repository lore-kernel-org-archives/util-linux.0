Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3A92FBDF5
	for <util-linux@vger.kernel.org>; Tue,  9 Dec 2025 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765306268; cv=none; b=W8Vabp6ACG8oLGes+U44Ns/3ymb7Kh5RFsWYieGvGYTuCiBqlniIt8Zng335j3ohQaufP3ie48Oel0ZSXyT/J/OIHfP5L/yUKejC+X0N5mPDsxZKfIgQtfL3ZdcI7bxL31C8kkk3Vh2mDcZG/hCwi7vty8A7psZNlcX+Xj1pgws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765306268; c=relaxed/simple;
	bh=LjhjXuBi54Z9UAgJvGdMFLxyQoObTS6R6mXtbm4idRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=theS2zWnMDyiXGZD8WrTQ7rgVhIoifSYtGjTnGsH7svbjk/mRm3m6Hiq+SgYtDp1njDTzCbqeyOaADLs403iv/DaBiSR86Ev2KB07AdFy3LCREBSFmDpslwi0hv95NNGTSmDXHjWNvGzBuSGg51gA17EaVktkDIDYK33PShqV54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=AwHcvw6t; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="AwHcvw6t"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ep99IvMm4hGDflM6GcoKH1+DoYUzLWYqm3K75W0tWRg=; b=AwHcvw6tLfUP5n0Gq1J5cu4ehU
	KXdOJBNQSf+dFGoKyHbJyGDErLBFoRgAzFf9ZbDT//MjJuYJkAFtOxFXcbTP9w1bHnddCaDGWOYMZ
	aA0lrpjIM9NvhW7vjd2TaQiyPS4JZ+1YixBNzJsJ1MEMa/UjbGvciIL3yD9P7EijFpxyu6kRvYYtZ
	2tvW7zXTy3jVI49tvKnxH4y5Af+FK+Qb/sVbB+br1t9HSwB+md6anR4NPwNc7Mr/r9yR0uqBxGb+y
	9e6pNIt+1/CEUTKhJmUbVkBgvgwtPfjIpz/xOCZL4HKxZJlrvlI8OrZ3a+kACSnGqvlPqcj62pr99
	h4OWYNaw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <zeha@debian.org>)
	id 1vT2nf-007Kjn-Gi; Tue, 09 Dec 2025 18:51:03 +0000
Date: Tue, 9 Dec 2025 19:50:59 +0100
From: Chris Hofstaedtler <zeha@debian.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: v2.41.3 planning
Message-ID: <oegibjegz34kkaahppwq6rkpitwc5hd6bmpne7ubpn7e4vb35e@wwbtzujfrvzo>
References: <ajxw7xn6mh3puhs44cmj5mxxe7stxqwqi3vzzzueqa4srn2zgx@iukpxdgp4dkk>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <ajxw7xn6mh3puhs44cmj5mxxe7stxqwqi3vzzzueqa4srn2zgx@iukpxdgp4dkk>
X-Debian-User: zeha

Hi Karel,

* Karel Zak <kzak@redhat.com> [251208 15:01]:
>I'd like to release the stable update v2.41.3, primarily to provide an
>upstream tarball with the fixed CVE-2025-14104 and to fix compilation
>with gcc-15, along with some other minor fixes.
>
>Do you see anything in the master branch that we need to include in
>this stable maintenance update?

Thank you. In Debian we picked c332544d215ccb466a64a441eb5a421b9fe8cdfd
"lscpu: use maximum CPU speed from DMI, avoid duplicate version 
string" because that seemed like a good fix to have.

I think this is not in stable/v2.41 so far. *Maybe* you want to 
consider it.

Best,
Chris

