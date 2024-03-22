﻿using System;
using System.Collections.Generic;

namespace reforco.db;

public partial class TbAutor
{
    public int IdAutor { get; set; }

    public string? Nome { get; set; }

    public string? Pais { get; set; }

    public string? NrFone { get; set; }

    public virtual ICollection<TbLivro> TbLivro { get; set; } = new List<TbLivro>();
}
