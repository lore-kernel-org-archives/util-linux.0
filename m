Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:31007 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756946Ab3ENLrN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 May 2013 07:47:13 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4EBlDuY013906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 14 May 2013 07:47:13 -0400
Date: Tue, 14 May 2013 12:47:05 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: ReFS
Message-ID: <20130514114705.GB17246@redhat.com>
References: <20130514110316.GA17246@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130514110316.GA17246@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Here's a blank, freshly created ReFS disk image (no partition table -
just the contents of the partition) if you want to look into this
further.

http://oirase.annexia.org/tmp/refs-blank.img.xz
8c72f6ef6541ad752a106604541055c7  refs-blank.img.xz

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
