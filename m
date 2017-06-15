Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:18428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752371AbdFOHws (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 15 Jun 2017 03:52:48 -0400
Date: Thu, 15 Jun 2017 09:52:44 +0200
From: Karel Zak <kzak@redhat.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: libblkid & empty identifier values
Message-ID: <20170615075244.xarzdd754ofbx3rp@ws.net.home>
References: <201706142304.34356@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <201706142304.34356@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jun 14, 2017 at 11:04:34PM +0200, Pali Rohár wrote:
> Hello!
> 
> Technically UDF filesystem allows to store empty string values. 
> LogicalVolumeIdentifier (label) according to UDF specification shall not 
> be null, but it is possible to store empty string there.
> 
> Question is, what should libblkid's udf code do if e.g. LABEL identifier 
> is empty string? Should it set empty LABEL for libblkid? Or it should 
> not set LABEL at all?
> 
> Currently in blkid_probe_set_label() is check for len > 1, so empty 
> string is not possible to store for LABEL. But when check fails function 
> return non-negative value which is understood as succeeded -- even it 
> did not store empty string. It does not looks good... Or it is expected?

IMHO think it's expected, blkid_probe_set_label() hides all the logic
to keep probing functions simple. So, LABEL is optional and libblkid
should not return any error if FS does not define any LABEL.  The
empty string as label is unwanted and unexpected by library clients.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
