Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B5F18DB01
	for <util-linux@vger.kernel.org>; Wed, 19 Mar 2025 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742391155; cv=none; b=Vyss7QtGZfZd6h6o047r2HvkmvmSd6UyhlNLURMGgWpy1nnwoUirHz5hDWzfB/a4SSCfw/ZAPY1GEjPCbrL0WAHnG+FzYPAPIovfeCzQiTDeYmNB2tUpKB+gKi4cXAiZE+sMnctVyqlT/jZIoQVFsoUYCrOTO5K2ayfpa6sbRFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742391155; c=relaxed/simple;
	bh=QXafkRXLan+MWbHKmIh/GlnfGUJG9VDjkHr0xjSh/n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npEqq+4feHg+ScMiMzgh3xlYUzweUozorbCedw4t8aHQTcEC+cN5CLIyQJE9ddRpUzuc7cGIak3y7q7EwC8277ssvSVdm4sXsJ8W42JerUGEaP77kmOzeAq3ZyH+eOu+G1y5cgv9ySDfYcrqoHadLUieNDjBn7PDFr8EtZ1Wstg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJ1osHoW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJ1osHoW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742391152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LttMIgxM9M3/MjPV4PRiT0AdQ+VpZU8bKIGB0drz2WQ=;
	b=jJ1osHoWLl6+lJur3SfssAZFaUz6ibthghFmzFRIDDV+05VpVwKxTWLzn5775di1rC1bej
	S2dzdnBagDQF/jML7kaI39eKXk59yhJXAkoRYW2eCRtaxXdPWKcEuU0LF+6/LOd/8fNWAS
	rHacKuMIYfaKsdF0PDojFhx0pQtKjDo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-6Rg0OV6ZNtiHbRw6IEwg1w-1; Wed,
 19 Mar 2025 09:32:29 -0400
X-MC-Unique: 6Rg0OV6ZNtiHbRw6IEwg1w-1
X-Mimecast-MFC-AGG-ID: 6Rg0OV6ZNtiHbRw6IEwg1w_1742391148
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C168B1955DBA;
	Wed, 19 Mar 2025 13:32:28 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.181])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C424119560AD;
	Wed, 19 Mar 2025 13:32:27 +0000 (UTC)
Date: Wed, 19 Mar 2025 14:32:24 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] more: ensure that on larger terminals 'h' shows only the
 in-app help text
Message-ID: <ev7vif5l3j45bcw7td4w4qehujwnrj7n2leg2y4324k4mrive5@fhd7i3wyezwg>
References: <20250318110108.5086-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318110108.5086-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Mar 18, 2025 at 12:01:08PM +0100, Benno Schulenberg wrote:
> When a terminal has more than 24 rows, the rows above the help text
> (shown by typing 'h' or '?') were still those of the displayed file.
> That could make it hard to notice that the two lines above the first
> row of dashes belonged to the help text, not to the displayed file.

This is a misunderstanding. By default, more(1) is in scroll mode, and
the help output is added to the display. Therefore, it is expected
that you see data from the file as well as the help text. You need to
use -c or -p to clear the screen before it prints the help text.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

