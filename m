Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DB92063FD
	for <util-linux@vger.kernel.org>; Tue,  8 Apr 2025 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115718; cv=none; b=PtRQC/Ug3dtN0p3Vi1XD5pQmuRxIu3i4W0KtgNqAUIvl5IlnpmJs8fycGNSXxEipJS31YiD+ulIhQ60VBQ7jAH9qvjeh5byK3AfvS71+Lhdx0i7ATbxXLLaWctzqSHQ1z9sK2odHO3lnfUQS6nZO2Iyvk3V5c+pQH/JNX7BZGYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115718; c=relaxed/simple;
	bh=48436JE7CsAslQ1xTCtQ7eZc/Nr3IkL2UZOBILjHvjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSqZPJ7Jrwy7PLCWWreHLdgJoF5+AXSuR7cK2lMcxPAfe7VMlFGl+QBddFCVtoBcnrDSQo3cc6+caq0rqHXU/sL+FrcPeZyQK8+4cAyoce2i+alHB1/nEnjWxhcyzL0YxDBeOpNVIx/AW8nzZWwi/u8cNoUNx4k3RdXUtYzU8Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=qgcpitWb; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="qgcpitWb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AG5/pTv5BZKYJxd3XXGE7smqxOm9lDv5yvZ2oGdjUwk=; b=qgcpitWbMON6pxwGPkYvRYqmQU
	RCVe0kDnUzwgbbcd7AAyakmDwrVnyiUXT68RmKTS66RlEGDrMJ9iAwgx29OxeN1cne1iP6NyB0O3n
	WzPAC17EJgjAzkdeeUxchVQ9Po5H0kAR07SeYVMUmkBOzYED2tktivxq4lqj6mU4lH3YFzt3t/HKI
	6CX6ONKJD9GGpBfHK97xV/xgfFQDD5sPTKVnyuTQ4i2VC20Y278k9BYpnyVv+pxMGeg99zjgL/grz
	PQM3QBvwBnKiPOGLazz4FBMSSfSXiYAQEdAwEcXdWEs7RAy0Rg1R1mBwcwPRaRf8GJownHQO+1yWy
	WtpRinnA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <zeha@debian.org>)
	id 1u28AW-00Faux-N5; Tue, 08 Apr 2025 12:35:08 +0000
Date: Tue, 8 Apr 2025 14:35:08 +0200
From: Chris Hofstaedtler <zeha@debian.org>
To: util-linux@vger.kernel.org
Cc: Benno Schulenberg <bensberg@telfort.nl>, Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 1/8] setarch: (man) remove a synopsis line that
 mistakenly mentions `arch`
Message-ID: <th24qbvmvco3w4oqwcfnxnacwrfcgpqs2qfp7whmam5gjm6wwn@fnajesleg2u4>
References: <20250407151503.23394-1-bensberg@telfort.nl>
 <mbag4aqfzuvn5q44cpbtem6ei7ai6jr2lz2pyzxrytsom4i3vq@7ak5vpzjgy7o>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <mbag4aqfzuvn5q44cpbtem6ei7ai6jr2lz2pyzxrytsom4i3vq@7ak5vpzjgy7o>
X-Debian-User: zeha

Hi,

* Karel Zak <kzak@redhat.com> [250408 12:36]:
>On Mon, Apr 07, 2025 at 05:14:32PM +0200, Benno Schulenberg wrote:
>> -*arch* [options] [_program_ [_argument_...]]
>
>This is not a bug. We use symlinks for setarch to support specific
>architectures. It would be beneficial to describe this in the man
>page in better way...
>
>$ find /usr/bin -type l -lname 'setarch'
>/usr/bin/i386
>/usr/bin/linux64
>/usr/bin/uname26
>/usr/bin/x86_64
>/usr/bin/linux32

There's a very old Debian bug (#530011) asking for the setarch man 
page to list all its aliases. Actually it started out asking what 
"arch" meant in there.

Maybe the man page really could list all known aliases?

Chris

