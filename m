Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5200B2144C7
	for <util-linux@vger.kernel.org>; Tue, 13 May 2025 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129339; cv=none; b=u6MXcOUpgIRw7w7bb7RxinVvruCbNcks+E1sVUZfjscTEOqk4xgjSEd3EZlgtcI38tGVhQGXX1yorq0Elp1v/rgMMiBodilJ1bE4KgzUbbonyU8J+xvsoMqJN30juDQGLc0VzuZPVdmwqoMZGfcCTJ671+SBFblPShT0A+TcdWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129339; c=relaxed/simple;
	bh=GDgWs2+TZwkpKbgbd4MLjhKQAReXb5DpzfzCNRZulGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hD+csLEqdHpraA3AW0FFv5HIrl60eETr9MqdPF5gsDK4ORT8HBc7zAvBPDj7XDDRQ0Hoai30d9ejEBN0IRLLXsgds9W9PsUMKDIhZz4xYXIpv6Q5P1XgqOQOYmIAIOHvSx5gKagsJrc2su6SZB2u1Mw5LK1s4F/FhRbQVmYcfO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aIXGcVmX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIXGcVmX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747129334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rJi244WifEPkW+3/9s+NbHg0aqnGeaKQUVGyOitaYdo=;
	b=aIXGcVmXo/jC31udvxUplTWWvScjWRiiTcodsFNV05Fwz4J/NCwaTY5408V0QBaQFCLXxw
	2mgi/OnCZ/392egHfaCADWFWJaZBaKndhSaHOezqk7m/gYCbyf44PfX0oJkPxt4DhSoFwU
	hB7uKUmGdesCOhbl/1NFtZeBVLwry94=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-_dyWyL17OCKjrFoXMvyA1A-1; Tue,
 13 May 2025 05:42:03 -0400
X-MC-Unique: _dyWyL17OCKjrFoXMvyA1A-1
X-Mimecast-MFC-AGG-ID: _dyWyL17OCKjrFoXMvyA1A_1747129320
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB89819560A7;
	Tue, 13 May 2025 09:42:00 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.128])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D219419560AB;
	Tue, 13 May 2025 09:41:59 +0000 (UTC)
Date: Tue, 13 May 2025 11:41:56 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: util-linux-2.41 breaks static build of btrfs-progs
Message-ID: <hu24dycwyxog44t6ttqidg5nkiczrufq3r3gy6slkgdubt55p4@7b6blpi2xciu>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sun, Apr 20, 2025 at 09:24:43PM +0200, Stanislav Brabec wrote:
> The question is:
> Should be this fixed by util-linux by prefixing of ul_ to all symbols that
> are not declared as static?

I have added the "ul_" prefix to some functions to make the names less
generic: https://github.com/util-linux/util-linux/pull/3569

I'm going to backport it to stable/v2.41 too.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

