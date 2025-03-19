Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58522259C9B
	for <util-linux@vger.kernel.org>; Wed, 19 Mar 2025 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742391885; cv=none; b=pdmTUyrmROdsOXdvLy341sOAni9HE8DiU083IiH6X20gAXKu0XebtBM55XXWQG3O+o/pgrTx4wE7u/T4olDhglYlwsPku6lNGauot01NJmUF90qFae7tEBzGjfb9XRAavqS27Usx0f1GbxkrPlZLJyeb5jcI61j9uLj8NLakONs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742391885; c=relaxed/simple;
	bh=Ho2EQO5klfJ/SvS6JkC8K7iXVRERGLHLljrbsA7wX4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJYcG6crwJKSViwUMbTvqCogn7gi9CKdPHpNQ/f0EbWj7seWqiqKsHibCDHuvx1tb3++t7QgYxjj9i8u4tPJFPg2RWnpIQsQCeDeO4t/bCFUkEc6jWCbsG9QmsGXC7yn4O3r/YiWsgWfvCATQYCE3oQdgUdqlLVhZbhZYm4APDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FN0xd8/F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FN0xd8/F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742391882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Qve4yHPJ5fQPoo+qrCwlHgZYLvCCP00mm3pprbbSzk=;
	b=FN0xd8/FqoXT7+2xQBKSBImBDAwvF0mwqFCp3k8T4ivdH4PgVICviPkIsDQtf1n8gAjUmc
	L5fbfIf80V1E+RPTm6WmfUATYLTH0tHL0vJINM9LkHv1IHcIlF5IqKvdpihuEeYNsJujXr
	V3TtjIeoACJgcMCvhSKEPq+OCak8aCQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-MJn_fx23MIiHsiT144EJnA-1; Wed,
 19 Mar 2025 09:44:40 -0400
X-MC-Unique: MJn_fx23MIiHsiT144EJnA-1
X-Mimecast-MFC-AGG-ID: MJn_fx23MIiHsiT144EJnA_1742391879
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACC52195608A;
	Wed, 19 Mar 2025 13:44:39 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.181])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B286419541A6;
	Wed, 19 Mar 2025 13:44:38 +0000 (UTC)
Date: Wed, 19 Mar 2025 14:44:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: bug in `more -c` when displayed file has blank lines in certain
 places
Message-ID: <cw62qayece3jj5xxzd4vbhhccdfd2az7ij2vadubzwpsz67nhc@pj4wa2ks7dhs>
References: <370e8be9-2e4b-4375-80dd-fdaf5a78944c@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <370e8be9-2e4b-4375-80dd-fdaf5a78944c@telfort.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Mar 18, 2025 at 11:44:25AM +0100, Benno Schulenberg wrote:
> 
> To reproduce, make it so that your terminal has 29 or 35 or 37 rows.
> Then run `./more -c NEWS` and type ? to display the in-app help text.
> (The NEWS file should be the one from util-linux-2.41-rc2.)
> 
> Then type <Space>.  See that the top row still displays the second line
> of the help text: "Star (*) indicates argument becomes new default."
> 
> Somehow `more -c` forgets to clear the top row when the corresponding
> line in the file is blank.
 
I can reproduce this bug. It seems that more(1), when used with -c
(ctl->clear_line_ends in the code), does not clear properly the screen
(after help) if there is an empty line in the file.

    Karel



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

