Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41324 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754596Ab1GMPzA convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 13 Jul 2011 11:55:00 -0400
Received: by wyg8 with SMTP id 8so240305wyg.19
        for <util-linux@vger.kernel.org>; Wed, 13 Jul 2011 08:54:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110713084243.GB3486@nb.net.home>
References: <CAAN0OpipdTBHfJGJG0s-YQQ0EbmrLzCkh6PWfHvVAdz78mFE6w@mail.gmail.com>
	<20110713084243.GB3486@nb.net.home>
Date: Wed, 13 Jul 2011 11:54:59 -0400
Message-ID: <CAAN0OpgF4fdOzMNSnDf_joqsrNqONdDg6UHzgJdAFadrUE1KAQ@mail.gmail.com>
Subject: Re: Error in man page for fstab
From: Brad Goodman <brad@bradgoodman.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 13, 2011 at 4:42 AM, Karel Zak <kzak@redhat.com> wrote:
> On Tue, Jul 12, 2011 at 12:21:58PM -0400, Brad Goodman wrote:
>> The fstab man page contains the following text:
>>
>> >> The third field, (fs_vfstype) ... An entry "none" is  useful  for bind or move mounts
>>
>> "none" is interpreted as an actual vfstype, which does not have the
>> intended consequences.
>
>  The bind mounts are completely independent on FS type. The type does
>  not make sense here. The recent version of the mount(8) always
>  overwrites the FS type to "none" for all MS_BIND, MS_MOVE and
>  MS_PROPAGATION operations.
>

If I specify "none" as the third parameter in fstab, and try to mount
a DVD, I get an error on mount:

Unrecognized fs type "none"

If I change this to "auto", it correctly mounts as iso9660.

-BKG
