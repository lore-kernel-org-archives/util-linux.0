Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B787194A44
	for <util-linux@vger.kernel.org>; Mon,  5 May 2025 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746437660; cv=none; b=DbX6AC5Dl33d+EXJo6CFlsELWz2fXU8OUvNCeCjpKRV+93CU+CnfePfgexvPH/QqhabKvcYS7HbzrDsZdNOYCyt+cCeeezCwW+4e1V91riW5MQU3epHpSB5xAmZWe5CSaMm/Yoty/eI/H3bc/z54+poqR33MEptBoqISH3P7BYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746437660; c=relaxed/simple;
	bh=ixt4WShSKED4b6BFVSsf5sdUOgyFMLCgwdxUhrH4FBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzDK+b2REAxS5vG/MJLrszfq8U3pFT967td7KU2r2Kd1mPcpedq9VHflkzPe2vsmoD+c+w9NH+meKpemBoB+KHMKtYjWE7tR8QyprHuMxZRwO0YMB97qcVMillFzMTRzjTrPuELaDB8ar+p/LbDPCchtS1PvbugV2VHhWtj1Am4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FgTtLJXn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FgTtLJXn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746437656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QVcPEiOYKKeeAtLyXsBHFJAJWF4yD0x8Icblblst+rs=;
	b=FgTtLJXnE0CW06aavCKmFxLpilWroaMn5IPx6jOwDyT8+jxp/XFhIKjBLmXYXFEPu9svP2
	UyvWZESt5EFRCnQnHMyLIxMaYpT/VtmeL/xHDeYAKk7bcoYNp7kA4inNEYOJNhcoT/YejC
	zjGuuLEFMSUaFNLevubtRuuEBwsIDmQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-uiqmQHEQOJ-EU5RwcKEEZw-1; Mon,
 05 May 2025 05:34:12 -0400
X-MC-Unique: uiqmQHEQOJ-EU5RwcKEEZw-1
X-Mimecast-MFC-AGG-ID: uiqmQHEQOJ-EU5RwcKEEZw_1746437652
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D50F3180034A;
	Mon,  5 May 2025 09:34:11 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.128])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA5071800365;
	Mon,  5 May 2025 09:34:10 +0000 (UTC)
Date: Mon, 5 May 2025 11:34:07 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: util-linux-2.41 breaks static build of btrfs-progs
Message-ID: <vy5gwsr6al5wl7nlksaq6orzkhhp4tog7gxtsjchl76ess5rtc@tmkazaywmvgv>
References: <ddfd6167-e88f-4505-8768-a9d8e1d5cc92@suse.cz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddfd6167-e88f-4505-8768-a9d8e1d5cc92@suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sun, Apr 20, 2025 at 09:24:43PM +0200, Stanislav Brabec wrote:
> Static build of btrfs-progs fails with util-linux-2.41 with a simple
> problem:
> Symbol parse_range becomes visible in libblkid.a, breaking parse-utils.c in
> btrfs-progs, using the same symbol.
> 
> The question is:
> Should be this fixed by util-linux by prefixing of ul_ to all symbols that
> are not declared as static?

I think the ul_ prefix should be used for all generic names like
parse_range(). I'm not sure if I want to use it strictly for all
functions, as the set of functions is large and such conflicts are
very rare.

ChatGPT has an interesting suggestion: add the prefix to the .a
library using "objcopy --redefine-syms" for all non-API and non-static
functions.

        #!/bin/bash
        PREFIX=foo_

        # Extract all global (non-static) function symbols from the .a file
        nm -g --defined-only libmylib.a | awk '{print $3}' | grep -v "^$PREFIX" | sort -u > tmp.syms

        # Generate rename list: <old> <new>
        awk -v pfx="$PREFIX" '{print $1 " " pfx $1}' tmp.syms > rename.syms

        # Apply symbol renaming
        objcopy --redefine-syms=rename.syms libmylib.a libmylib_prefixed.a


Maybe it's elegant way to go. Not sure, not tested :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

