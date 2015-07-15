Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ig0-f171.google.com ([209.85.213.171]:32993 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbbGON2s (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 15 Jul 2015 09:28:48 -0400
Received: by iggp10 with SMTP id p10so121087481igg.0
        for <util-linux@vger.kernel.org>; Wed, 15 Jul 2015 06:28:48 -0700 (PDT)
Date: Wed, 15 Jul 2015 09:28:32 -0400 (EDT)
From: Scott Moser <smoser@ubuntu.com>
To: "Dale R. Worley" <worley@alum.mit.edu>
cc: util-linux@vger.kernel.org
Subject: Re: GPT writing of unknown partition uuids
In-Reply-To: <87mvyymf1p.fsf@hobgoblin.ariadne.com>
Message-ID: <alpine.DEB.2.02.1507150920190.30147@brickies>
References: <87mvyymf1p.fsf@hobgoblin.ariadne.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, 14 Jul 2015, Dale R. Worley wrote:

> Scott Moser <smoser@ubuntu.com> writes:
> > If sfdisk does not know the uuid provided, it silently falls back to
> > 0FC63DAF-8483-4772-8E79-3D69D8477DE4 (Linux filesystem).
> >
> > It seems like if the user provided you with a GUID, sfdisk should trust
> > them, or at very least exit failure if it refuses to use the provided
> > GUID.
>
> Ugh, you're right!  Silent disobedience is pernicious.

My hack / "will this work" to fdisk_label_parse_parttype seemed to get a
functional fdisk_new_unknown_parttype that would be used.

diff --git a/libfdisk/src/parttype.c b/libfdisk/src/parttype.c
index aedf4e8..bda850a 100644
--- a/libfdisk/src/parttype.c
+++ b/libfdisk/src/parttype.c
@@ -335,6 +335,7 @@ struct fdisk_parttype *fdisk_label_parse_parttype(
 		if (ret)
 			goto done;

+		typestr = str;
 		/* maybe specified by order number */
 		errno = 0;
 		i = strtol(str, &end, 0);
@@ -347,7 +348,7 @@ struct fdisk_parttype *fdisk_label_parse_parttype(

 	ret = fdisk_new_unknown_parttype(code, typestr);
 done:
-	DBG(PARTTYPE, ul_debugobj(ret, "returns parsed '%s' partition type", ret->name));
+	DBG(PARTTYPE, ul_debugobj(ret, "returns parsed '%s' partition type (%s)", ret->name, ret->typestr));
 	return ret;
 }

