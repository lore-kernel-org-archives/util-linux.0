Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f176.google.com ([209.85.128.176]:34770 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752073AbdFOH5a (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 15 Jun 2017 03:57:30 -0400
Received: by mail-wr0-f176.google.com with SMTP id 77so10003602wrb.1
        for <util-linux@vger.kernel.org>; Thu, 15 Jun 2017 00:57:25 -0700 (PDT)
Date: Thu, 15 Jun 2017 09:57:22 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: libblkid & empty identifier values
Message-ID: <20170615075722.GO5248@pali>
References: <201706142304.34356@pali>
 <20170615075244.xarzdd754ofbx3rp@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170615075244.xarzdd754ofbx3rp@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 15 June 2017 09:52:44 Karel Zak wrote:
> On Wed, Jun 14, 2017 at 11:04:34PM +0200, Pali Rohár wrote:
> > Hello!
> > 
> > Technically UDF filesystem allows to store empty string values. 
> > LogicalVolumeIdentifier (label) according to UDF specification shall not 
> > be null, but it is possible to store empty string there.
> > 
> > Question is, what should libblkid's udf code do if e.g. LABEL identifier 
> > is empty string? Should it set empty LABEL for libblkid? Or it should 
> > not set LABEL at all?
> > 
> > Currently in blkid_probe_set_label() is check for len > 1, so empty 
> > string is not possible to store for LABEL. But when check fails function 
> > return non-negative value which is understood as succeeded -- even it 
> > did not store empty string. It does not looks good... Or it is expected?
> 
> IMHO think it's expected, blkid_probe_set_label() hides all the logic
> to keep probing functions simple. So, LABEL is optional and libblkid
> should not return any error if FS does not define any LABEL.  The
> empty string as label is unwanted and unexpected by library clients.

Ok, in this case special logic for parsing empty UDF dstring identifiers
is not needed as they would be just ignored by libblkid (empty dstrings
are stored specially).

-- 
Pali Rohár
pali.rohar@gmail.com
