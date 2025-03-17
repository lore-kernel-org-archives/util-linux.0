Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A373B23CF12
	for <util-linux@vger.kernel.org>; Mon, 17 Mar 2025 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209127; cv=none; b=M7mYWVGzfpKwUxsDaTnqtDgrS/a6f20g5FGl6YL5LKCggY2EHvJPUEgGBYktghe2U/amXD4c84kPVav9jYN+6G0fp+gKe9dQTmXZ8Su3SfbPehCZ4dqwBhAzVSXJHkkkfyZ7/ppS63oSubQmoRXocn6GK9vUGKEMjPWYaLkCoPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209127; c=relaxed/simple;
	bh=CJXRuKTXHNd6MJ7F17Lgjwn+kLoHOCdKTMHSW7yfkIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpvcRAMFKILWDQiTNfjkdKdtyw21XOJzrN5VmuCbgior9OUlwl3n1tn+ZZD/RRHV6rmz8fb+85EolfDZDcZh4jPVibLyNugAIBNGWFAwtihpDoIyc21UcGcuzLoLfgngZERGkYOwpu69Q1olLc7Gmv3WNhnZ8Vjg72QDkinZxFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LNL+Ed4u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNL+Ed4u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742209124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GBXT/9RNL0iHK9bULB/ECLHV/MtF41jPUpFlzsYBrpI=;
	b=LNL+Ed4uyxz4Q4t0ud2um2UUaTw41GrOJhoCA/QRNedPzy5UlpoYpnkxAmZMqWOkzlhwgs
	u1D2RmoIAU4Iraqo6Ywz/Bpj683xebggdy0JoRgT7NsepY1oZgLPF0TwKLGZbCwsGm+8AN
	ETuM2CjzcfdVEdWwwj3qBLwvoHVqFGc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-cjGsBrgKPLmAsFB6FXgFFQ-1; Mon,
 17 Mar 2025 06:58:41 -0400
X-MC-Unique: cjGsBrgKPLmAsFB6FXgFFQ-1
X-Mimecast-MFC-AGG-ID: cjGsBrgKPLmAsFB6FXgFFQ_1742209120
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C1BB19560BD;
	Mon, 17 Mar 2025 10:58:40 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.181])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C0A71955DCD;
	Mon, 17 Mar 2025 10:58:38 +0000 (UTC)
Date: Mon, 17 Mar 2025 11:58:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: bug in `more -c` when using . to repeat <enter>
Message-ID: <m633xtvsldssilgylxennikyqgrcvjda6wyitzkh74botdbqni@gvisx77odjzp>
References: <b354fc17-f706-4a56-a271-592cd44a7b5d@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b354fc17-f706-4a56-a271-592cd44a7b5d@telfort.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sun, Mar 16, 2025 at 04:45:42PM GMT, Benno Schulenberg wrote:
> 
> To reproduce, run `./more -c README`.  Type <enter> a few times,
> and see that for each <enter> the screen scrolls one line to show
> another line of the README.  (Except when there is a blank line:
> then it scrolls two lines and shows two blank lines -- that is
> probably a separate bug.)
> 
> Now type . instead, which should repeat the last command, in this
> case <enter>.  See how the screen is cleared and just one line of
> the README is shown.  Keep typing . and see that each time just
> one line is displayed.  Typing . here behaves as if the user had
> typed 1 <enter>, not just <enter>.
> 
> Bug was found while using `./page README` after `ln -s more page`.
> But `./page` does not do the doubling of blank lines.

 Fixed, thanks for your report!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

