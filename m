Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B110813F44C
	for <util-linux@vger.kernel.org>; Wed, 15 May 2024 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715782954; cv=none; b=vBdUBc7MNTo+ZbwkVqbx59qeQb1OCrERUEwvxYuLb5o/f1/08lTmMfb2tl7eF61CEjoAL4lsxLTk+K1+eSy0mV6HYUdRe1eD0ktWYV/5XAsF86GTXJkxeQY3OlN5Ii9KT6WYsDzZF1Ex0CqwkQuQR+mDAowTYChGoyyUJAviJzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715782954; c=relaxed/simple;
	bh=zv97FD37hMiLTiowym635rmmUTM343LLTknUkt0p9E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CURcXxnkG3DHVXXLljBwnEnOL44Q8WLfJgB0CDZW5ir6yzZFMQcWgmtOcfLjKNtlOipDKGVPK4CKPSUNKiOcavGa5VLaiia4H660KRFl6v8k4N8wcmSDWkKvlxHLjBobqDA4+WSy995ljBtXSVZ2w5imJ5sudt4snEc5o6E0GNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xnjho1gd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xnjho1gd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715782950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0SIwFTIgZyygm8mEjm0cml2Kqkmf2c2TfDxP55ODHsU=;
	b=Xnjho1gdy/7l5+ZQ2B1dWyEi+yuJ5oK9GHT7lRnIYDDn+CCeSubbs6MnONsZls+eW3/aWY
	q+fgOEjQgHfQyWH+2w0MuwyjLdnTd5Bls7F0cgG0DZK0FdkqxKf5OND9uTeFWriNzhkmsK
	aMEiP119HWwUovrTn9ND7qALI5FQLmI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-i_dspaWAN3aZWFgMftjaXA-1; Wed,
 15 May 2024 10:22:29 -0400
X-MC-Unique: i_dspaWAN3aZWFgMftjaXA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C54E738000AB;
	Wed, 15 May 2024 14:22:28 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.202])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F7387412;
	Wed, 15 May 2024 14:22:28 +0000 (UTC)
Date: Wed, 15 May 2024 16:22:26 +0200
From: Karel Zak <kzak@redhat.com>
To: Alyssa Ross <hi@alyssa.is>
Cc: util-linux@vger.kernel.org
Subject: Re: Parallel build failures with util-linux 2.40
Message-ID: <20240515142226.oyp37o3fkajvpoal@ws.net.home>
References: <87le4c1zm4.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87le4c1zm4.fsf@alyssa.is>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Tue, May 14, 2024 at 12:01:23PM +0200, Alyssa Ross wrote:
> Since updating from util-linux 2.39.3 to 2.40.1 in Nixpkgs, we've been
> seeing intermittent parallel build failures like the following:

What does it mean "parallel build"? make -j ?

> libtool: warning(B: relinking 'pam_lastlog2.la'(B libtool: install:
> (cd /build/util-linux-2.40.1;
> /nix/store/306znyj77fv49kwnkpxmb0j2znqpa8bj-bash-5.2p26/bin/bash
> "/build/util-linux-2.40.1/libtool"  --silent --tag CC --mode=relink
> gcc -fsigned-char -fno-common -Wall -Wextra
> -Waddress-of-packed-member -Wdiscarded-qualifiers -Wformat-security
> -Wimplicit-function-declaration -Wmissing-declarations
> -Wmissing-parameter-type -Wmissing-prototypes -Wnested-externs
> -Wno-missing-field-initializers -Wold-style-definition
> -Wpointer-arith -Wredundant-decls -Wsign-compare -Wstrict-prototypes
> -Wtype-limits -Wuninitialized -Wunused-but-set-parameter
> -Wunused-but-set-variable -Wunused-parameter -Wunused-result
> -Wunused-variable -Wvla -Walloca -Werror=sequence-point
> -I./liblastlog2/src -g -O2 -module -avoid-version -shared
> pam_lastlog2_la_LDFLAGS +=

I'm not sure, but it seems like you're being affected by an extra "+="
in the LDFLAGS. This should be fixed by...

    https://github.com/util-linux/util-linux/commit/290748729dc3edf9ea1c680c8954441a5e367a44
    https://github.com/util-linux/util-linux/commit/597e8b246ae31366514ead6cca240a09fe5e1528

Can you try your use case with the latest git tree?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

