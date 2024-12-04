import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'tela_cadastro_cliente.dart';

class TelaCliente extends StatefulWidget {
  final Map<String, dynamic> cliente;
  const TelaCliente({Key? key, required this.cliente}) : super(key: key);
  @override
  _TelaClienteState createState() => _TelaClienteState();
}

class _TelaClienteState extends State<TelaCliente> {
  late Map<String, dynamic> cliente;

  @override
  void initState() {
    super.initState();
    cliente = widget.cliente;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações de ${cliente['nome'] ?? ''}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaCadastroCliente(cliente: cliente),
                ),
              );
              if (result != null) {
                setState(() {
                  cliente = {...cliente, ...result};
                });
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._buildInformationList(cliente),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _exportarParaPDF,
                  child: const Text('Exportar para PDF'),
                ),
                ElevatedButton(
                  onPressed: _exportarParaCSV,
                  child: const Text('Exportar para CSV'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildInformationList(Map<String, dynamic> clientData) {
    final informationItems = {
      'Nome': 'nome',
      'Data de Nascimento': 'data_nascimento',
      'Escolaridade': 'escolaridade',
      'Profissão': 'profissao',
      'Estado Civil': 'estado_civil',
      'Já realizou algum tratamento estético?': 'tratamento_estetico',
      'Descrição do Tratamento Estético': 'tratamento_estetico_descricao',
      'Tem filhos?': 'tem_filhos',
      'Está amamentando?': 'amamentando',
      'Como funciona seu intestino?': 'intestino',
      'Ingere água?': 'ingere_agua',
      'Hábitos alimentares?': 'habitos_alimentares',
      'Possui intolerância alimentar?': 'intolerancia_alimentar',
      'Descrição da Intolerância Alimentar': 'intolerancia_alimentar_descricao',
      'Ingere bebida alcoólica?': 'ingere_bebida_alcoolica',
      'Fuma?': 'fuma',
      'Como é o seu sono?': 'sono',
      'Pratica atividade física?': 'atividade_fisica',
      'Usa cosméticos? Descrição': 'usa_cosmeticos_descricao',
      'Alergias ou irritações? Descrição': 'alergias_irritacoes_descricao',
      'Tem patologias? Descrição': 'tem_patologias_descricao',
      'Tem distúrbio hormonal? Descrição': 'tem_disturbio_hormonal_descricao',
      'Uso de medicamentos? Descrição': 'uso_medicamento_descricao',
      'Deficiência de vitaminas? Descrição': 'deficiencia_vitaminas_descricao',
      'Avaliação da pele': 'avaliacao_pele',
      'Tratamento': 'tratamento',
      'Produtos para usar em casa': 'produtos_para_casa',
    };

    return informationItems.entries.map((entry) {
      final value = clientData[entry.value];
      final formattedValue = value is bool ? _formatarBool(value) : value ?? '';
      return _buildInformationRow(entry.key, formattedValue);
    }).toList();
  }


  Widget _buildInformationRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  String _formatarBool(bool value) => value ? 'Sim' : 'Não';

  Future<void> _exportarParaPDF() async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(build: (context) => _buildPdfContent()));
    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  pw.Widget _buildPdfContent() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Informações do Cliente', style: pw.TextStyle(fontSize: 24)),
        pw.SizedBox(height: 20),
        ..._buildPdfInformationList(cliente),
      ],
    );
  }


  List<pw.Widget> _buildPdfInformationList(Map<String, dynamic> clientData) {
      final informationItems = {
      'Nome': 'nome',
      'Data de Nascimento': 'data_nascimento',
      'Escolaridade': 'escolaridade',
      'Profissão': 'profissao',
      'Estado Civil': 'estado_civil',
      'Já realizou algum tratamento estético?': 'tratamento_estetico',
      'Descrição do Tratamento Estético': 'tratamento_estetico_descricao',
      'Tem filhos?': 'tem_filhos',
      'Está amamentando?': 'amamentando',
      'Como funciona seu intestino?': 'intestino',
      'Ingere água?': 'ingere_agua',
      'Hábitos alimentares?': 'habitos_alimentares',
      'Possui intolerância alimentar?': 'intolerancia_alimentar',
      'Descrição da Intolerância Alimentar': 'intolerancia_alimentar_descricao',
      'Ingere bebida alcoólica?': 'ingere_bebida_alcoolica',
      'Fuma?': 'fuma',
      'Como é o seu sono?': 'sono',
      'Pratica atividade física?': 'atividade_fisica',
      'Usa cosméticos? Descrição': 'usa_cosmeticos_descricao',
      'Alergias ou irritações? Descrição': 'alergias_irritacoes_descricao',
      'Tem patologias? Descrição': 'tem_patologias_descricao',
      'Tem distúrbio hormonal? Descrição': 'tem_disturbio_hormonal_descricao',
      'Uso de medicamentos? Descrição': 'uso_medicamento_descricao',
      'Deficiência de vitaminas? Descrição': 'deficiencia_vitaminas_descricao',
      'Avaliação da pele': 'avaliacao_pele',
      'Tratamento': 'tratamento',
      'Produtos para usar em casa': 'produtos_para_casa',
    };

    return informationItems.entries.map((entry) {
      final value = clientData[entry.value];
      final formattedValue = value is bool ? _formatarBool(value) : value ?? '';
      return _buildPdfInformationRow(entry.key, formattedValue);
    }).toList();
  }


  pw.Widget _buildPdfInformationRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4.0),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('$label: ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Expanded(child: pw.Text(value)),
        ],
      ),
    );
  }

  Future<void> _exportarParaCSV() async {
    final rows = [
      ['Campo', 'Valor'],
      ..._buildCsvData(cliente),
    ];
    final csvData = const ListToCsvConverter().convert(rows);

    try {
      final directory = await getExternalStorageDirectory();
      final path = "${directory!.path}/cliente_${cliente['id']}.csv";
      await File(path).writeAsString(csvData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Arquivo CSV salvo em: $path')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar arquivo CSV: $e')),
      );
    }
  }

  List<List<dynamic>> _buildCsvData(Map<String, dynamic> clientData) {
    final informationItems = {
      'Nome': 'nome',
      'Data de Nascimento': 'data_nascimento',
      'Escolaridade': 'escolaridade',
      'Profissão': 'profissao',
      'Estado Civil': 'estado_civil',
      'Já realizou algum tratamento estético?': 'tratamento_estetico',
      'Descrição do Tratamento Estético': 'tratamento_estetico_descricao',
      'Tem filhos?': 'tem_filhos',
      'Está amamentando?': 'amamentando',
      'Como funciona seu intestino?': 'intestino',
      'Ingere água?': 'ingere_agua',
      'Hábitos alimentares?': 'habitos_alimentares',
      'Possui intolerância alimentar?': 'intolerancia_alimentar',
      'Descrição da Intolerância Alimentar': 'intolerancia_alimentar_descricao',
      'Ingere bebida alcoólica?': 'ingere_bebida_alcoolica',
      'Fuma?': 'fuma',
      'Como é o seu sono?': 'sono',
      'Pratica atividade física?': 'atividade_fisica',
      'Usa cosméticos? Descrição': 'usa_cosmeticos_descricao',
      'Alergias ou irritações? Descrição': 'alergias_irritacoes_descricao',
      'Tem patologias? Descrição': 'tem_patologias_descricao',
      'Tem distúrbio hormonal? Descrição': 'tem_disturbio_hormonal_descricao',
      'Uso de medicamentos? Descrição': 'uso_medicamento_descricao',
      'Deficiência de vitaminas? Descrição': 'deficiencia_vitaminas_descricao',
      'Avaliação da pele': 'avaliacao_pele',
      'Tratamento': 'tratamento',
      'Produtos para usar em casa': 'produtos_para_casa',
    };

    return informationItems.entries.map((entry) {
      final value = clientData[entry.value];
      final formattedValue = value is bool ? _formatarBool(value) : value ?? '';
      return [entry.key, formattedValue];
    }).toList();
  }
}