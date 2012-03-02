Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:11492 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758438Ab2CBPKW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 2 Mar 2012 10:10:22 -0500
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q22FAM5A003698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 2 Mar 2012 10:10:22 -0500
Received: from x2 (ovpn-116-18.ams2.redhat.com [10.36.116.18])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q22FAKPT004194
	for <util-linux@vger.kernel.org>; Fri, 2 Mar 2012 10:10:21 -0500
Date: Fri, 2 Mar 2012 16:10:19 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: Re: v2.22 wish list
Message-ID: <20120302151019.GH18642@x2.net.home>
References: <20120229154420.GD8471@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120229154420.GD8471@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Feb 29, 2012 at 04:44:20PM +0100, Karel Zak wrote:
> 
> This is my v2.22 wish list. The list contains large/invasive tasks only. 
> Comments, volunteers, .... ? ;-)

 I forgot one important item:

   * add device-mapper support to partx to make it compatible with
     kpartx (then we can remove kpartx from distros...)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
